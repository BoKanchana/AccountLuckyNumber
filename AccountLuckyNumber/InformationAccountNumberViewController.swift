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
  
  @IBOutlet weak var viewaccountNumber: UIView!
  
  @IBOutlet weak var accountNumber: UILabel!
  override func viewDidLoad() {
        super.viewDidLoad()
      viewmain.layer.cornerRadius = 5.0
      viewmain.layer.shadowColor = UIColor.gray.cgColor
      viewmain.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
      viewmain.layer.shadowRadius = 5.0
      viewmain.layer.shadowOpacity = 0.7
    
//    viewaccountNumber.animateWithDuration(2, animations: { () -> Void in
//      accountNumber.backgroundColor = UIColor.redColor();
//    })
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
