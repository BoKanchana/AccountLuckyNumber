//
//  LuckyNumberCollectionTableViewCell.swift
//  AccountLuckyNumber
//
//  Created by Pawee Kittiwathanakul on 2/10/2562 BE.
//  Copyright © 2562 bobo. All rights reserved.
//

import UIKit

class LuckyNumberCollectionTableViewCell: UITableViewCell {
  
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var luckynumberTypeImageVIew: UIImageView!
  @IBOutlet weak var viewContent: UIView!
  
  func setUi(lucknumberTypeAtIndex : LuckNumberType) {
    
    luckynumberTypeImageVIew.image = UIImage(named: lucknumberTypeAtIndex.image)
    titleLabel.text = lucknumberTypeAtIndex.title
    descriptionLabel.text = lucknumberTypeAtIndex.discription
    viewContent.layer.cornerRadius = 5.0
    viewContent.layer.shadowColor = UIColor.gray.cgColor
    viewContent.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    viewContent.layer.shadowRadius = 5.0
    viewContent.layer.shadowOpacity = 0.7
    
  }

    
}
