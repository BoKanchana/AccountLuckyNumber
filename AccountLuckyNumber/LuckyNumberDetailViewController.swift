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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getLuckyNumberDetail()
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
