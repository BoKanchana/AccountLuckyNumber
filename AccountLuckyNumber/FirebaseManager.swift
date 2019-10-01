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
  private var ACCOUNT_KEY = "AccountNumber"
  private var LUCKY_NUMBER = "LuckyNumber"
  
  private var list = [AccountNumber]()
  
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
  
}
