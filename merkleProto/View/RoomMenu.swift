//
//  RoomMenu.swift
//  merkleProto
//
//  Created by Clyfford Millet on 8/27/18.
//  Copyright © 2018 Clyff Millet. All rights reserved.
//

import UIKit
import APNGKit

protocol RoomMenuDelegate: class {
    func presentMoneyVC()
}

class RoomMenu: UIView {
    
    weak var delegate:RoomMenuDelegate?
    
    
    
    
    @IBOutlet var menuAnimApngView1: APNGImageView!
    @IBOutlet var menuAnimApngView2: APNGImageView!
    @IBOutlet var menuAnimApngView3: APNGImageView!

    
    
    let nibName = "RoomMenu"
    var contentView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.addSubview(view)
        contentView = view
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.addSubview(view)
        contentView = view
    }
    
   
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @IBAction func moneyBtn(_ sender: Any) {

        
      
        
        delegate?.presentMoneyVC()
        
    }
    @IBAction func shopBtn(_ sender: Any) {
    }
    @IBAction func merklesBtn(_ sender: Any) {
    }
    
    
}
