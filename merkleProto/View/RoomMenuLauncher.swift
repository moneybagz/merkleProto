//
//  RoomMenuLauncher.swift
//  merkleProto
//
//  Created by Clyfford Millet on 8/27/18.
//  Copyright © 2018 Clyff Millet. All rights reserved.
//



import UIKit
import APNGKit

let path = Bundle.main.path(forResource: "menu1", ofType: "png")
let path2 = Bundle.main.path(forResource: "menu2", ofType: "png")
let path3 = Bundle.main.path(forResource: "menu3", ofType: "png")


class RoomMenuLauncher: NSObject {
    
    let blackView = UIView()
    let roomMenu: RoomMenu = {
        let window = UIApplication.shared.keyWindow
        let rm = RoomMenu(frame: CGRect(x: 0 - (window?.frame.width)! / 4 * 3, y: 0, width: (window?.frame.width)! / 4 * 3, height: (window?.frame.height)!))
        return rm
    }()
    let menuAnim1 = APNGImage(contentsOfFile: path!)
    let menuAnim2 = APNGImage(contentsOfFile: path2!)
    let menuAnim3 = APNGImage(contentsOfFile: path3!)

    
    func showMenu() {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self
                , action: #selector(handleDismiss)))
            
            
            blackView.frame = window.frame
            blackView.alpha = 0
            window.addSubview(blackView)
            

            window.addSubview(roomMenu)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                
                self.roomMenu.frame = CGRect(x: 0, y: 0, width: self.roomMenu.frame.width, height: self.roomMenu.frame.height
                )
                
            }, completion: { (finished: Bool) in
                
                self.menuAnim1?.repeatCount = 1
                self.roomMenu.menuAnimApngView1.image = self.menuAnim1
                self.roomMenu.menuAnimApngView1.startAnimating()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.menuAnim2?.repeatCount = 1
                    self.roomMenu.menuAnimApngView2.image = self.menuAnim2
                    self.roomMenu.menuAnimApngView2.startAnimating()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        self.menuAnim3?.repeatCount = 1
                        self.roomMenu.menuAnimApngView3.image = self.menuAnim3
                        self.roomMenu.menuAnimApngView3.startAnimating()
                    }
                }
            })
            
        }
    }
    
    @objc func handleDismiss() {
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0

            if let window = UIApplication.shared.keyWindow {
                self.roomMenu.frame = CGRect(x: 0 - (window.frame.width) / 4 * 3, y: 0, width: self.roomMenu.frame.width, height: self.roomMenu.frame.height
                )
            }
            
            self.roomMenu.menuAnimApngView1.image = nil
            self.roomMenu.menuAnimApngView2.image = nil
            self.roomMenu.menuAnimApngView3.image = nil
            
        }, completion: nil)
    }
    
    override init() {
        super.init()
    }
}
