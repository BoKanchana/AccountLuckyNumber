//
//  LuckNumberListViewController.swift
//  AccountLuckyNumber
//
//  Created by Pawee Kittiwathanakul on 2/10/2562 BE.
//  Copyright © 2562 bobo. All rights reserved.
//

import UIKit

class LuckNumberListViewController: UIViewController {
  private var firebase: FirebaseManager!
  var luckNumbers : [LuckyNumber] = []
  var color = UIColor()
  @IBOutlet weak var luckyNumberImageView: UIImageView!
  
  
  var emptyDict = Dictionary<String, Any>()
  @IBOutlet weak var colletionview: UICollectionView!
  override func viewDidLoad() {
        super.viewDidLoad()
    
    navigationController?.navigationBar.barTintColor = UIColor.green
    firebase = FirebaseManager()
    let bundle = Bundle(for: LuckyNumberListCollectionViewCell.self)
    let nib = UINib(nibName: "LuckyNumberListCollectionViewCell", bundle: bundle)
    colletionview.register(nib, forCellWithReuseIdentifier: "LuckyNumberListCollectionViewCell")
    
    let image = UIImage(named: "LuckNumberOfLove") ?? UIImage()
    luckyNumberImageView.image = convertToGrayScale(image: image)
    getLuckyNumberList(accountName: "Work")
    
    }
  
  func setnavigationColor() {
    var color = UIColor.init(
    
  }
  
  func getLuckyNumberList(accountName: String) {
     firebase.getLuckyNumberList(collection: accountName) { [weak self] (data) in
     
      for item in data {
        print("Item : \(item)")
        
      }
      self?.luckNumbers = data
      
      DispatchQueue.main.async {
         self?.colletionview.reloadData()
      }
    }
  }
  
  func convertToGrayScale(image: UIImage) -> UIImage {
    let imageRect:CGRect = CGRect(x:0, y:0, width:image.size.width, height: image.size.height)
    let colorSpace = CGColorSpaceCreateDeviceGray()
    let width = image.size.width
    let height = image.size.height
    
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
    let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
    //have to draw before create image
    
    context?.draw(image.cgImage!, in: imageRect)
    let imageRef = context!.makeImage()
    let newImage = UIImage(cgImage: imageRef!)
    
    return newImage
  }
  

}

extension LuckNumberListViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return luckNumbers.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LuckyNumberListCollectionViewCell", for: indexPath) as? LuckyNumberListCollectionViewCell else {
        return UICollectionViewCell()
    }
    let luckyNubmerIndex = luckNumbers[indexPath.row]
    cell.setUi(lucynumberAtIndex: luckyNubmerIndex)
    
    
    
    
    
    
    
    
    return cell
  }
  
  
}

//extension LuckyNumberListCollectionViewCell : UICollectionViewDelegate {
//   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    return CGSize(width: CGFloat(400), height: CGFloat(100))
//  }
//}
extension LuckNumberListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.size.width
    let height = CGFloat(100)
    return CGSize(width: width, height: height)
  }
}

extension LuckNumberListViewController : UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    performSegue(withIdentifier: "LuckyNumberListGoToLuckNumberDetail", sender: nil)
  }
}
