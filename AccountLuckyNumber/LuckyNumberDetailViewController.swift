//
//  LuckyNumberDetailViewController.swift
//  AccountLuckyNumber
//
//  Created by Pawee Kittiwathanakul on 2/10/2562 BE.
//  Copyright © 2562 bobo. All rights reserved.
//

import UIKit

class LuckyNumberDetailViewController: UIViewController {
  var deeplink: String = ""
  @IBAction func getToken(_ sender: Any) {
    FirebaseManager().getAccessToken()
  }
  
  @IBAction func generateDeeplink(_ sender: Any) {
    FirebaseManager().generateDeeplink() { result in
      let results: [String: AnyObject] = result as! [String : AnyObject]
      for index in results {
        if index.key == "deeplinkUrl" {
          self.deeplink = index.value as! String
          print("deeplink: \(index)")
        }
      }
    }
  }
  
  @IBAction func goToEasyApp(_ sender: Any) {
    UIApplication.shared.openURL(NSURL(string: "\(deeplink)?callback_url=accountluckynumber://")! as URL)
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
