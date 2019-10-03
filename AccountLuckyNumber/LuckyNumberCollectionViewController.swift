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
                                         title: "ความรัก",
                                         discription: "เลขบัญชีที่ส่งเสริมเรื่อง ความรัก เพื่อให้ทุกคนมีรักที่ดี มีความหวังที่สดใส พร้อมรักษาหัวใจให้สดชื่นไว้ในทุกวัน", status: "Love"),
                          LuckNumberType(image: "workpictrue",
                                         title: "การงาน",
                                         discription: "เลขบัญชีที่เหมาะสมกับอาชีพเพื่อเพิ่มศักยภาพในการทำงาน และเพิ่มโอกาศของการประสบความสำเร็จ", status: "Work")]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.backgroundColor = UIColorFromRGB(rgbValue: 0x572993)
        navigationController?.navigationBar.barTintColor = UIColorFromRGB(rgbValue: 0x572993)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "LuckyNumberCollectionViewControllerGoToLuckyNumberList" {
        if let viewController = segue.destination as? LuckNumberListViewController, let sender = sender  {
            viewController.status = sender as! String
        }
      }
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
        let status = luckNumberType[indexPath.row].status
      
        performSegue(withIdentifier: "LuckyNumberCollectionViewControllerGoToLuckyNumberList", sender: status)
    }
}
