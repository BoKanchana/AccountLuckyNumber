//
//  LuckyNumberDetailViewController.swift
//  AccountLuckyNumber
//
//  Created by Kanchana Phakdeedorn on 30/9/2562 BE.
//  Copyright © 2562 bobo. All rights reserved.
//

import UIKit

class LuckyNumberDetailViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getAccountNumber()
  }
  
  func getAccountNumber() {
    let collection = "Work"
    let id = "1234567890"
    FirebaseManager().getLuckyNumberDetail(collection: collection, id: id) { result in
      print("result: \(result)")
    }
  }
  
}
