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
    var status :String = ""
    @IBOutlet weak var luckyNumberImageView: UIImageView!
    
    
    var emptyDict = Dictionary<String, Any>()
    @IBOutlet weak var colletionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //add type 
        self.title = "ความรัก"

        firebase = FirebaseManager()
        let bundle = Bundle(for: LuckyNumberListCollectionViewCell.self)
        let nib = UINib(nibName: "LuckyNumberListCollectionViewCell", bundle: bundle)
        colletionview.register(nib, forCellWithReuseIdentifier: "LuckyNumberListCollectionViewCell")
      
      if status == "Love" {
        let image = UIImage(named: "LuckNumberOfLove") ?? UIImage()
        luckyNumberImageView.image = imageWithGradient(img: image)
      }else {
        let image = UIImage(named: "workpictrue") ?? UIImage()
        luckyNumberImageView.image = imageWithGradient(img: image)
      }
        getLuckyNumberList(accountName: status)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.backgroundColor = UIColorFromRGB(rgbValue: 0x572993)
        navigationController?.navigationBar.barTintColor = UIColorFromRGB(rgbValue: 0x572993)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "LuckyNumberListGoToLuckNumberDetail" {
      if let viewController = segue.destination as? LuckyNumberDetailViewController, let sender = sender  {
        viewController.lucky = sender as! LuckyNumber
        viewController.status = status
      }
    }
  }
}

extension LuckNumberListViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return luckNumbers.count
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
    let lucky = luckNumbers[indexPath.row]
    performSegue(withIdentifier: "LuckyNumberListGoToLuckNumberDetail", sender: lucky)
  }
}
