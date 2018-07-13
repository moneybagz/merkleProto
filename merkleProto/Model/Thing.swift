//
//  Thing.swift
//  merkleProto
//
//  Created by Clyfford Millet on 6/9/18.
//  Copyright © 2018 Clyff Millet. All rights reserved.
//

import Foundation
import UIKit

struct Thing {
    
    private var _name: String!
    private var _access: Bool!
    private var _bought: Bool!
    private var _cost: Int!
    private var _imageUrl: String!
    // Can i have a private optional???
    private var _unlockable: [String]!
    
    var name: String {
        return _name
    }
    
    var access: Bool {
        return _access
    }
    
    var bought: Bool {
        return _bought
    }
    
    var cost: Int {
        return _cost
    }
    
    var imageUrl: String {
        return _imageUrl
    }
    
    var unlockable: Array<String> {
        return _unlockable
    }
    
    
    
    init(name: String, access: Bool, bought: Bool, cost: Int, imageUrl: String, unlockable: [String]) {
        
        self._name = name
        self._access = access
        self._bought = bought
        self._cost = cost
        self._imageUrl = imageUrl
        self._unlockable = unlockable
    }
}
