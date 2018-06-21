//
//  DataService.swift
//  merkleProto
//
//  Created by Clyfford Millet on 6/11/18.
//  Copyright © 2018 Clyff Millet. All rights reserved.
//

import Foundation
import Firebase

let DB_Base = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_Base
    private var _REF_USERS = DB_Base.child("users")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func createTimeStamp(withUid uid: String, completion: @escaping () -> ()) {
        REF_USERS.child(uid).updateChildValues(["timeStamp": ServerValue.timestamp()] as [String : Any], withCompletionBlock: {error, ref in
            
            if error != nil{
                print("ERROR")
            }
            else{
                completion()
            }
        })
    }
    
    func getTimeStamp(withUID uid: String, handler: @escaping (_ timeStamp: NSNumber) -> ()) {
        REF_USERS.child(uid).child("timeStamp").observeSingleEvent(of: .value) { (timeSnapshot) in
            if let t = timeSnapshot.value as? NSNumber {
                print("\(t)")
                handler(t)
            } else { return }
        }
    }
    
    func createSecondTimeStamp(withUid uid: String, completion: @escaping () -> ()) {
        REF_USERS.child(uid).updateChildValues(["timeStampTwo": ServerValue.timestamp()] as [String : Any], withCompletionBlock: {error, ref in
            
            if error != nil{
                print("ERROR")
            }
            else{
                completion()
            }
        })
    }
    
    func getSecondTimeStamp(withUID uid: String, handler: @escaping (_ timeStamp: NSNumber) -> ()) {
        REF_USERS.child(uid).child("timeStampTwo").observeSingleEvent(of: .value) { (timeSnapshot) in
            if let t = timeSnapshot.value as? NSNumber {
                print("\(t)")
                handler(t)
            } else { return }
        }
    }
    
    func postMoney(withUid uid: String, money: Int, completion: @escaping () -> ()) {
        REF_USERS.child(uid).updateChildValues(["money": money], withCompletionBlock: {error, ref in
            
            if error != nil{
                print("ERROR")
            }
            else{
                completion()
            }
        })
    }
    
    func getMoney(withUid uid: String, handler: @escaping (_ cash: Int) -> ()) {
        REF_USERS.child(uid).child("money").observeSingleEvent(of: .value) { (moneySnapshot) in
            if let money = moneySnapshot.value as? Int {
                handler(money)
            } else { return }
        }
    }
    
    func getRoomData(withUid uid: String, roomNumber: String, handler: @escaping (_ things: [Thing]) -> ()) {
        var thingsArray = [Thing]()
        REF_USERS.child(uid).child("room1").observeSingleEvent(of: .value) { (roomSnapshot) in
            guard let roomSnapshot = roomSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for item in roomSnapshot {
                let name = item.childSnapshot(forPath: "name").value as! String
                let access = item.childSnapshot(forPath: "access").value as! Bool
                let bought = item.childSnapshot(forPath: "bought").value as! Bool
                let cost = item.childSnapshot(forPath: "cost").value as! Int
                let thing = Thing(name: name, access: access, bought: bought, cost: cost)
                thingsArray.append(thing)
            }
            
            handler(thingsArray)
        }
    }
}
