//
//  FirebaseManager.swift
//  AccountLuckyNumber
//
//  Created by Kanchana Phakdeedorn on 1/10/2562 BE.
//  Copyright © 2562 bobo. All rights reserved.
//

import Foundation
import Firebase
import Alamofire

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
struct LuckNumberType {
  let image : String
  let title :String
  let discription:String
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
    
    func getId(_ accountNumber: String) -> String {
        return accountNumber.replacingOccurrences(of: "-", with: "")
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
        self.ref.child(ACCOUNT_KEY).child(getId(account.accountNumber)).setValue(
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
        self.ref.child(ACCOUNT_KEY).child(getId(accNumber)).observeSingleEvent(of: .value, with: { (snapshot) in if let response = snapshot.value as? NSDictionary {
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
        self.ref.child(ACCOUNT_KEY).child(getId(toAccount.accountNumber)).setValue(data) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("\(Response.updateError.rawValue): \(error).")
            } else {
                print(Response.updateSuccess.rawValue)
            }
        }
    }
    
    func deleteAccountNumber(accountNumber: String) {
        self.ref.child(ACCOUNT_KEY).child(getId(accountNumber)).removeValue() {
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
    
    func setAccountLuckyNumber(account: AccountNumber, lucky: LuckyNumber) {
        self.ref.child(ACCOUNT_AND_LUCKY_KEY).child(getId(account.accountNumber)).setValue(
            [Key.accountLuckyNumber.rawValue:lucky.accountLuckyNumber,
             Key.accountNumber.rawValue:account.accountNumber]
        ) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("\(Response.createError.rawValue): \(error).")
            } else {
                print(Response.createSuccess.rawValue)
            }
        }
    }
    
    func getAccountLuckyNumber(accNumber: String, completion: @escaping (LuckyNumber) -> Void) {
        self.ref.child(ACCOUNT_AND_LUCKY_KEY).child(getId(accNumber)).observeSingleEvent(of: .value, with: { (snapshot) in if let response = snapshot.value as? NSDictionary {
//            TODO: get LuckyNumber info and send with completion
//            completion()
            }
        }) { (error) in
            //            print(error.localizedDescription)
            print("\(Response.readError.rawValue): \(error).")
        }
    }
    
    func updateAccountLuckyNumber(fromAccountNumber: String, withLuckyNumber: LuckyNumber) {
        let data = [Key.accountLuckyNumber.rawValue:withLuckyNumber.accountLuckyNumber,
                    Key.accountNumber.rawValue:fromAccountNumber]
        self.deleteAccountNumber(accountNumber: fromAccountNumber)
        self.ref.child(ACCOUNT_AND_LUCKY_KEY).child(getId(fromAccountNumber)).setValue(data) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("\(Response.updateError.rawValue): \(error).")
            } else {
                print(Response.updateSuccess.rawValue)
            }
        }
    }
    
    func deleteAccountLuckyNumber(accountNumber: String) {
        self.ref.child(ACCOUNT_AND_LUCKY_KEY).child(getId(accountNumber)).removeValue() {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("\(Response.deleteError.rawValue): \(error).")
            } else {
                print(Response.deleteSuccess.rawValue)
            }
        }
    }
  
  func getAccessToken() {
    let body: [String: Any] = [
      "applicationKey" : "l7a02b32cbfd774988882e58a6c2d5c77e",
      "applicationSecret" : "a1d71fad366340d8bd4a7516f5c5d250"
    ]
    let urlString = "https://api.partners.scb/partners/sandbox/v1/oauth/token"
    let headers: HTTPHeaders = ["Content-Type": "application/json",
                                "resourceOwnerId": "l7a02b32cbfd774988882e58a6c2d5c77e",
                                "requestUId": "1",
                                "accept-language": "EN"]
    
    Alamofire.request(urlString,
                      method: .post,
                      parameters: body,
                      encoding: JSONEncoding.default,
                      headers: headers).responseJSON { (response) -> Void in
                        switch response.result {
                          
                        case .success(let json):
                          print(json)
                        case .failure(let error):
                          print(error)
                        }
    }
  }
  
  func generateDeeplink(completion: @escaping(_ result: Any) -> Void) {
    let urlString = "https://api.partners.scb/partners/sandbox/v3/deeplink/transactions"
    let ref: Parameters = ["paymentAmount": 100.00,
                           "accountTo": "448204658651865",
                           "ref1": "QMM",
                           "ref2": "QMM",
                           "ref3": "QMM"]
    
    let body: Parameters = ["transactionType": "PURCHASE",
                            "transactionSubType": ["BP"],
                            "sessionValidityPeriod": 1800,
                            "sessionValidUntil": "",
                            "billPayment": ref]
    let headers: HTTPHeaders = ["Content-Type": "application/json",
                                "authorization": "Bearer c908bf29-7c0a-492d-94bc-898d791a1ffe",
                                "resourceOwnerId": "l7a02b32cbfd774988882e58a6c2d5c77e",
                                "requestUId": "1",
                                "channel": "scbeasy"]
    Alamofire.request(urlString,
                      method: .post,
                      parameters: body,
                      encoding: JSONEncoding.default,
                      headers: headers).responseJSON { (response) -> Void in
                        switch response.result {
                        case .success(let json):
                          let data = json as! [String: AnyObject]
                          for index in data {
                            if index.key == "data" {
                              print("data: \(index)")
                              completion(index.value)
                            }
                          }
                        case .failure(let error):
                          print(error)
                        }
    }
  }
    
    
}

