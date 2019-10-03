//
//  ViewController.swift
//  AccountLuckyNumber
//
//  Created by Kanchana Phakdeedorn on 30/9/2562 BE.
//  Copyright © 2562 bobo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var firebase: FirebaseManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebase = FirebaseManager()
        createAccountNumber(accountNumber: AccountNumber(accountNumber: "111-111-111-1", accountType: "saving", firstname: "Noey", lastname: "Eeng"))
        getAccountNumberDict()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func createAccountNumber(accountNumber: AccountNumber) {
        firebase.createAccountNumber(account: accountNumber)
    }
    
    func getAccountNumberDict() {
        firebase.getAccountNumberDict() { [weak self] (data) in
            for item in data {
                print("getAccountList() = \(item)")
            }
        }
    }
    
    func getAccountNumber(accountName: String) {
        firebase.getAccountNumber(accNumber: accountName) { [weak self] (data) in
            print("getAccount() = \(data)")
        }
    }
    
    func updateAccountNumber(fromAccountNumber: String, toAccount: AccountNumber) {
        firebase.updateAccountNumber(fromAccountNumber: fromAccountNumber, toAccount: toAccount)
    }
    
    func deleteAccountNumber(accountNumber: String) {
        firebase.deleteAccountNumber(accountNumber: accountNumber)
    }
    
}

