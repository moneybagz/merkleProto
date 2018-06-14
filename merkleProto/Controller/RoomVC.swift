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
        
        //var user = Auth.auth().currentUser!.uid)
        
        
        //FIREBASE SIGNOUT
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
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

