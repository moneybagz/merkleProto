//
//  ViewController.swift
//  merkleProto
//
//  Created by Clyfford Millet on 6/7/18.
//  Copyright © 2018 Clyff Millet. All rights reserved.
//

import UIKit
import Firebase

class RoomVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var roomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Pull Money but if on first run post $0 first
        if UserDefaults.standard.bool(forKey: "notFirstRun") == false {
            UserDefaults.standard.set(true, forKey: "notFirstRun")
            DataService.instance.postMoney(withUid: Auth.auth().currentUser!.uid, money: 0) {
                DataService.instance.getMoney(withUid: Auth.auth().currentUser!.uid) { (cash) in
                    Money.instance.money = cash
                    print("\(String(describing: Money.instance.money))*************")
                }
            }
        } else {
            DataService.instance.getMoney(withUid: Auth.auth().currentUser!.uid) { (cash) in
                Money.instance.money = cash
                print("\(String(describing: Money.instance.money))*************")
            }
        }
        

        
        
        //FIREBASE SIGNOUT
//        do {
//            try Auth.auth().signOut()
//            print("you are logged out!!!!!!!!!!!!!")
//        } catch let logoutError {
//            print(logoutError)
//        }
        
        
        // For Zooming
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2.0
        scrollView.zoomScale = 1.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Scroll View delegate for zooming
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return roomView
    }

    @IBAction func unwind(_ sender: UIStoryboardSegue){}
}

