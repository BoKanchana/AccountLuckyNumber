//
//  LuckyNumberDetailViewController.swift
//  AccountLuckyNumber
//
//  Created by Pawee Kittiwathanakul on 2/10/2562 BE.
//  Copyright © 2562 bobo. All rights reserved.
//

import UIKit

class LuckyNumberDetailViewController: UIViewController {
  
  @IBOutlet weak var luckyNumberImage: UIImageView!
  @IBOutlet weak var luckyNumberLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBAction func confirmOrderButton(_ sender: Any) {
    generateDeeplink()
  }
  var token: String = ""
  var lucky: LuckyNumber?
  var luckyNumberDetail: LuckyNumber?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getLuckyNumberDetail()
    getAccessToken()
  }
  
  func getAccessToken() {
    FirebaseManager().getAccessToken() { result in
      self.token = result as! String
    }
  }
  
  func generateDeeplink() {
    FirebaseManager().generateDeeplink(token: token) { result in
      let deeplink = result as! String
      if deeplink != "" {
        self.goToEasyApp(deeplink: deeplink)
        self.setAccountLuckyNumber()
      }
    }
  }
  
  func goToEasyApp(deeplink: String) {
    UIApplication.shared.openURL(NSURL(string: "\(deeplink)?callback_url=accountluckynumber://")! as URL)
  }
  
  func getLuckyNumberDetail() {
    let collection = "Work"
    FirebaseManager().getLuckyNumberDetail(collection: collection, id: lucky!.accountLuckyNumber) { result in
      let accountLuckyNumber = result.accountLuckyNumber
      let description = result.description
      let price = result.price
      let status = result.status
      let type = result.type
      
      self.luckyNumberDetail = LuckyNumber(accountLuckyNumber: accountLuckyNumber,
                                           description: description,
                                           price: price,
                                           status: status,
                                           type: type)
      self.luckyNumberLabel.text = result.accountLuckyNumber
      self.descriptionLabel.text = result.description
    }
  }
  
  func setAccountLuckyNumber() {
    let accountNumber = AccountNumber(accountNumber: "1234567890",
                                      accountType: "saving",
                                      firstname: "ปวีร์",
                                      lastname: "กิตติวัฒนากุล")
    let lucky: LuckyNumber = luckyNumberDetail!
    FirebaseManager().setAccountLuckyNumber(account: accountNumber, lucky: lucky)
  }
  
}
