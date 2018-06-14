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
        REF_USERS.child(uid).child("timeStamp").observe(.value) { (timeSnapshot) in
            if let t = timeSnapshot.value as? NSNumber {
                // Cast the value to an NSTimeInterval
                // and divide by 1000 to get seconds.
                print("\(t)")
                handler(t)
            } else { return }
//            guard let time = timeSnapshot.value as? [DataSnapshot] else { return }
//            let number = time["timeStamp"]
//            if let number = time as? TimeInterval {
//                print("\(number)")
//            }
        }
        
//        ref.observeEventType(.Value, withBlock: {
//            snap in
//            if let t = snap.value as? NSTimeInterval {
//                // Cast the value to an NSTimeInterval
//                // and divide by 1000 to get seconds.
//                println(NSDate(timeIntervalSince1970: t/1000))
//            }
//        })
    }
    
    
}
