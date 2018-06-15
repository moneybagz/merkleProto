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
    
    func createTimeStamp(withUid uid: String) {
        REF_USERS.child(uid).updateChildValues(["timeStamp": ServerValue.timestamp()] as [String : Any])
    }
    
    func getTimeStamp(withUID uid: String, handler: @escaping (_ timeStamp: NSNumber) -> ()) {
        REF_USERS.child(uid).child("timeStamp").observeSingleEvent(of: .value) { (timeSnapshot) in
            if let t = timeSnapshot.value as? NSNumber {
                print("\(t)")
                handler(t)
            } else { return }
        }
    }
    
    func createSecondTimeStamp(withUid uid: String) {
        REF_USERS.child(uid).updateChildValues(["secondTimeStamp": ServerValue.timestamp()] as [String : Any])
    }
    
    func getSecondTimeStamp(withUID uid: String, handler: @escaping (_ timeStamp: NSNumber) -> ()) {
        REF_USERS.child(uid).child("secondTimeStamp").observeSingleEvent(of: .value) { (timeSnapshot) in
            if let t = timeSnapshot.value as? NSNumber {
                print("\(t)")
                handler(t)
            } else { return }
        }
    }
}
