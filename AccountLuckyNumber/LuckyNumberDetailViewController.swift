//
//  LuckyNumberDetailViewController.swift
//  AccountLuckyNumber
//
//  Created by Pawee Kittiwathanakul on 2/10/2562 BE.
//  Copyright © 2562 bobo. All rights reserved.
//

import UIKit

class LuckyNumberDetailViewController: UIViewController {
  
  
  @IBOutlet weak var viewmain: UIView!
  @IBOutlet weak var luckyNumberLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBAction func confirmOrderButton(_ sender: Any) {
    generateDeeplink()
  }
  var token: String = ""
  var status:String = ""
  var lucky: LuckyNumber?
  var luckyNumberDetail: LuckyNumber?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getLuckyNumberDetail()
    getAccessToken()
    loadShadow()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    title = "เลขบัญชีมงคล"
    navigationController?.setNavigationBarHidden(false, animated: animated)
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    navigationController?.navigationBar.backgroundColor = UIColorFromRGB(rgbValue: 0x572993)
    navigationController?.navigationBar.barTintColor = UIColorFromRGB(rgbValue: 0x572993)
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }
  
  func loadShadow() {
    viewmain.layer.cornerRadius = 12.0
    viewmain.layer.shadowColor = UIColor.gray.cgColor
    viewmain.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    viewmain.layer.shadowRadius = 5.0
    viewmain.layer.shadowOpacity = 0.2
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
    self.navigationController?.popToRootViewController(animated: false)
    UIApplication.shared.openURL(NSURL(string: "\(deeplink)?callback_url=accountluckynumber://")! as URL)
  }
  
  func getLuckyNumberDetail() {
    FirebaseManager().getLuckyNumberDetail(collection: status, id: lucky!.accountLuckyNumber) { result in
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
