//
//  InformationAccountNumberViewController.swift
//  AccountLuckyNumber
//
//  Created by Pawee Kittiwathanakul on 3/10/2562 BE.
//  Copyright © 2562 bobo. All rights reserved.
//

import UIKit

class InformationAccountNumberViewController: UIViewController {
  
  @IBOutlet weak var viewmain: UIView!
  @IBOutlet weak var accountNumberLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "รายละเอียดบัญชี"
    
    viewmain.layer.cornerRadius = 12.0
    viewmain.layer.shadowColor = UIColor.gray.cgColor
    viewmain.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    viewmain.layer.shadowRadius = 5.0
    viewmain.layer.shadowOpacity = 0.2
    
    getAccountNumber()
    
    //    viewaccountNumber.animateWithDuration(2, animations: { () -> Void in
    //      accountNumber.backgroundColor = UIColor.redColor();
    //    })
    
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    navigationController?.navigationBar.titleTextAttributes = textAttributes
  }
  
  func getAccountNumber() {
    let accountNumber = "123-456-789-0"
    accountNumberLabel.text = accountNumber
    FirebaseManager().getAccountLuckyNumber(accNumber: accountNumber) { result in
      let accountLuckyNumber = result.accountLuckyNumber
      if accountLuckyNumber != "" {
        self.accountNumberLabel.text = accountLuckyNumber
      }
    }
  }
  
}
