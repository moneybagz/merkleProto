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
    private var _openToBuy: Bool!
    private var _bought: Bool!
    //private var _image: UIImage!
    private var _cost: Int!
    //private var _unlockable: [String]
    
    var name: String {
        return _name
    }
    
    var openToBuy: Bool {
        return _openToBuy
    }
    
    var bought: Bool {
        return _bought
    }
    
    var cost: Int {
        return _cost
    }
    
    init(name: String, openTobuy: Bool, bought: Bool, cost: Int) {
        
        self._name = name
        self._openToBuy = openTobuy
        self._bought = bought
        self._cost = cost
    }
}
