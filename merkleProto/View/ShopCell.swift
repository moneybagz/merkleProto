//
//  ShopCell.swift
//  merkleProto
//
//  Created by Clyfford Millet on 6/20/18.
//  Copyright © 2018 Clyff Millet. All rights reserved.
//

import UIKit

class ShopCell: UICollectionViewCell {
    
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var amountLbl: UILabel!
    @IBOutlet var thingImageView: UIImageView!
    
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(thing: Thing) {
        
        nameLbl.text = thing.name
        amountLbl.text = "$\(thing.cost)"
        //function in extensions file
        thingImageView.loadImagesUsingCacheWithUrlString(urlString: thing.imageUrl)
        
    }
}
