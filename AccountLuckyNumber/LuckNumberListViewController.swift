//
//  LuckNumberListViewController.swift
//  AccountLuckyNumber
//
//  Created by Pawee Kittiwathanakul on 2/10/2562 BE.
//  Copyright © 2562 bobo. All rights reserved.
//

import UIKit

class LuckNumberListViewController: UIViewController {

  @IBOutlet weak var colletionview: UICollectionView!
  override func viewDidLoad() {
        super.viewDidLoad()

    let bundle = Bundle(for: LuckyNumberListCollectionViewCell.self)
    let nib = UINib(nibName: "LuckyNumberListCollectionViewCell", bundle: bundle)
    colletionview.register(nib, forCellWithReuseIdentifier: "LuckyNumberListCollectionViewCell")
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

extension LuckNumberListViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 6
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LuckyNumberListCollectionViewCell", for: indexPath) as? LuckyNumberListCollectionViewCell else {
        return UICollectionViewCell()
    }
    cell.setUi()
    
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
    let width = collectionView.frame.size.width / 2.5
    let height = CGFloat(100)
    return CGSize(width: width, height: height)
  }
}

extension LuckNumberListViewController : UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    performSegue(withIdentifier: "LuckyNumberListGoToLuckNumberDetail", sender: nil)
  }
}
