//
//  FirebaseManager.swift
//  AccountLuckyNumber
//
//  Created by Kanchana Phakdeedorn on 1/10/2562 BE.
//  Copyright © 2562 bobo. All rights reserved.
//

import Foundation
import Firebase

struct AccountNumber {
  var accountNumber: String
  var accountType: String
  var firstname: String
  var lastname: String
}

struct LuckyNumber {
  var accountLuckyNumber: String
  var description: String
  var price: Int
  var status: String
  var type: String
}

struct LuckyNumberCollection {
  var name: String
  var collection: [LuckyNumber]
}

class FirebaseManager {
  private var ref: DatabaseReference!

  private var list = [AccountNumber]()

  private var ACCOUNT_KEY = "AccountNumber"
  private var LUCKY_NUMBER = "LuckyNumber"
  private var ACCOUNT_AND_LUCKY_KEY = "AccountLuckyNumber"

  init() {
    ref = Database.database().reference()
  }
  
  func getAccountNumberDict(completion: @escaping ([AccountNumber]) -> Void) {
    self.ref.child(ACCOUNT_KEY).observe(DataEventType.value, with: { (snapshot) in
      // TODO: check response
      if let response = snapshot.value as? [String : AnyObject] {
        for data in response.values {
          let account = AccountNumber(accountNumber: data["accountNumber"] as! String,
                                      accountType: data["accountType"] as! String,
                                      firstname: data["firstname"] as! String,
                                      lastname: data["lastname"] as! String
          )
          self.list.append(account)
        }
        completion(self.list)
      }
    })
  }
  
  func getLuckyNumberCollection(completion: @escaping ([Any]) -> Void) {
    self.ref.child(LUCKY_NUMBER).observe(DataEventType.value, with: { (snapshot) in
      if let response = snapshot.value as? [String: AnyObject] {
        let collection = response.map { result in result.key }
        print("collection: \(collection)")
        completion(collection)
      }
    })
  }
  
  
  func getLuckyNumberList(collection: String, completion: @escaping ([LuckyNumberCollection]) -> Void) {
    self.ref.child(LUCKY_NUMBER).observe(DataEventType.value, with: { (snapshot) in
      if let response = snapshot.value as? [String: AnyObject] {
        let collection = response.filter { result in result.key == collection }
        print("collection: \(collection)")
      }
    })
  }
  
  func getLuckyNumberDetail(collection: String, id: String, completion: @escaping (LuckyNumber) -> Void) {
    self.ref.child(LUCKY_NUMBER).observe(DataEventType.value, with:  { (snapshot) in
      if let response = snapshot.value as? [String: AnyObject] {
        let collection = response.filter { result in result.key == collection }
        let detail = collection.filter { result in result.key == id }
        print("Work: \(detail)")
      }
    })
  }
    
    func createAccountNumber(account: AccountNumber) {
        self.ref.child(ACCOUNT_KEY).child(account.accountNumber).setValue(
            [Key.accountNumber.rawValue:account.accountNumber,
             Key.accountType.rawValue:account.accountType,
             Key.firstname.rawValue:account.firstname,
             Key.lastname.rawValue:account.lastname]
        ) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("\(Response.createError.rawValue): \(error).")
            } else {
                print(Response.createSuccess.rawValue)
            }
        }
    }
    
    func getAccountNumberDict(completion: @escaping ([AccountNumber]) -> Void) {
        self.ref.child(ACCOUNT_KEY).observe(DataEventType.value, with: { (snapshot) in
            // TODO: check response
            if let response = snapshot.value as? [String : AnyObject] {
                for data in response.values {
                    let account = AccountNumber(accountNumber: data["accountNumber"] as! String,
                                                accountType: data["accountType"] as! String,
                                                firstname: data["firstname"] as! String,
                                                lastname: data["lastname"] as! String
                    )
                    self.list.append(account)
                }
                completion(self.list)
            }
        })
    }
    
    func getAccountNumber(accNumber: String, completion: @escaping (AccountNumber) -> Void) {
        self.ref.child(ACCOUNT_KEY).child(accNumber).observeSingleEvent(of: .value, with: { (snapshot) in
            if let response = snapshot.value as? NSDictionary {
                let account = AccountNumber(accountNumber: response.value(forKey: "accountNumber") as! String,
                                            accountType: response.value(forKey: "accountType") as! String,
                                            firstname: response.value(forKey: "firstname") as! String,
                                            lastname: response.value(forKey: "lastname") as! String)
                completion(account)
            }
        }) { (error) in
            //            print(error.localizedDescription)
            print("\(Response.readError.rawValue): \(error).")
        }
    }
    
    func updateAccountNumber(fromAccountNumber: String, toAccount: AccountNumber) {
        let data = [Key.accountNumber.rawValue:toAccount.accountNumber,
                    Key.accountType.rawValue:toAccount.accountType,
                    Key.firstname.rawValue:toAccount.firstname,
                    Key.lastname.rawValue:toAccount.lastname]
        self.deleteAccountNumber(accountNumber: fromAccountNumber)
        self.ref.child(ACCOUNT_KEY).child(toAccount.accountNumber).setValue(data) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("\(Response.updateError.rawValue): \(error).")
            } else {
                print(Response.updateSuccess.rawValue)
            }
        }
    }
    
    func deleteAccountNumber(accountNumber: String) {
        self.ref.child(ACCOUNT_KEY).removeValue() {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("\(Response.deleteError.rawValue): \(error).")
            } else {
                print(Response.deleteSuccess.rawValue)
            }
        }
        
        // or set empty data
        //        self.ref.child(ACCOUNT_KEY).child(accountNumber).setValue([:]) {
        //            (error:Error?, ref:DatabaseReference) in
        //            if let error = error {
        //                print("\(Response.deleteError.rawValue): \(error).")
        //            } else {
        //                print(Response.deleteSuccess.rawValue)
        //            }
        //        }
    }
    
}

