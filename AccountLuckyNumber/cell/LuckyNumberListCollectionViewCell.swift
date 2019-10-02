//
//  LuckyNumberListCollectionViewCell.swift
//  AccountLuckyNumber
//
//  Created by Pawee Kittiwathanakul on 2/10/2562 BE.
//  Copyright © 2562 bobo. All rights reserved.
//

import UIKit

class LuckyNumberListCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var accountNumberLabel: UILabel!
  
  @IBOutlet weak var view: UIView!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  func setUi() {
   
    view.layer.cornerRadius = 5.0
    view.layer.shadowColor = UIColor.gray.cgColor
    view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    view.layer.shadowRadius = 5.0
    view.layer.shadowOpacity = 0.7
  }

}
