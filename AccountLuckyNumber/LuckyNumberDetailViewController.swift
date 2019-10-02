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
      }
    }
  }
  
  func goToEasyApp(deeplink: String) {
    UIApplication.shared.openURL(NSURL(string: "\(deeplink)?callback_url=accountluckynumber://")! as URL)
  }
  
  func getLuckyNumberDetail() {
    let collection = "Work"
    let id = "9999999999"
    FirebaseManager().getLuckyNumberDetail(collection: collection, id: id) { result in
      self.luckyNumberLabel.text = result.accountLuckyNumber
      self.descriptionLabel.text = result.description
    }
  }
  
}
