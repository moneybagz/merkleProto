//
//  RoomMenuLauncher.swift
//  merkleProto
//
//  Created by Clyfford Millet on 8/27/18.
//  Copyright © 2018 Clyff Millet. All rights reserved.
//



import UIKit

class RoomMenuLauncher: NSObject {
    
    let blackView = UIView()
    let roomMenu: RoomMenu = {
        let window = UIApplication.shared.keyWindow
        let rm = RoomMenu(frame: CGRect(x: 0 - (window?.frame.width)! / 4 * 3, y: 0, width: (window?.frame.width)! / 4 * 3, height: (window?.frame.height)!))
        return rm
    }()

    
    func showMenu() {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self
                , action: #selector(handleDismiss)))
            
            
            blackView.frame = window.frame
            blackView.alpha = 0
            window.addSubview(blackView)
            

            window.addSubview(roomMenu)
            
            UIView.animate(withDuration: 0.5) {
                self.blackView.alpha = 1
                
                self.roomMenu.frame = CGRect(x: 0, y: 0, width: self.roomMenu.frame.width, height: self.roomMenu.frame.height
                )
            }
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.roomMenu.frame = CGRect(x: 0 - (window.frame.width) / 4 * 3, y: 0, width: self.roomMenu.frame.width, height: self.roomMenu.frame.height
                )
            }
        }
    }
    
    override init() {
        super.init()
    }
}
