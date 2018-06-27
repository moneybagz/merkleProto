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
        
        //let url = URL(fileURLWithPath: thing.imageUrl)
        if let url = URL(string: thing.imageUrl) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                //download hit an error so lets return out
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                
                DispatchQueue.main.async {
                    self.thingImageView.image = UIImage(data: data!)
                }
            }.resume()
        }
    }
}
