//
//  LuckyNumberCollectionViewController.swift
//  AccountLuckyNumber
//
//  Created by Pawee Kittiwathanakul on 2/10/2562 BE.
//  Copyright © 2562 bobo. All rights reserved.
//

import UIKit

class LuckyNumberCollectionViewController: UIViewController {
    var luckNumberType : [LuckNumberType] = []
    
    @IBOutlet weak var luckyNumberCollectionLabelText: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = StringResource.luckyCategoryTitle.rawValue
        luckyNumberCollectionLabelText.text = StringResource.chooseLuckyCategoryTitle.rawValue
       

        let bundle = Bundle(for: LuckyNumberCollectionTableViewCell.self)
        let nib = UINib(nibName: "LuckyNumberCollectionTableViewCell", bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: "LuckyNumberCollectionTableViewCell")
        luckNumberType = [LuckNumberType(image: "LuckNumberOfLove",
                                         title: "Test01",
                                         discription: "TestDes01"),
                          LuckNumberType(image: "LuckyNumberOfWork",
                                         title: "Test02",
                                         discription: "TestDes02")]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.backgroundColor = UIColorFromRGB(rgbValue: 0x572993)
        navigationController?.navigationBar.barTintColor = UIColorFromRGB(rgbValue: 0x572993)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

}

extension LuckyNumberCollectionViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return luckNumberType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LuckyNumberCollectionTableViewCell", for: indexPath) as? LuckyNumberCollectionTableViewCell else {
            return UITableViewCell()
        }
        
        let lucknumbertype = luckNumberType[indexPath.row]
        cell.setUi(lucknumberTypeAtIndex: lucknumbertype)
        
        return cell
    }
    
}

extension LuckyNumberCollectionViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "LuckyNumberCollectionViewControllerGoToLuckyNumberList", sender: nil)
    }
}
