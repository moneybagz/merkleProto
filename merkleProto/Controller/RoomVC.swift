//
//  ViewController.swift
//  merkleProto
//
//  Created by Clyfford Millet on 6/7/18.
//  Copyright © 2018 Clyff Millet. All rights reserved.
//

import UIKit
import Firebase
import APNGKit


class RoomVC: UIViewController, UIScrollViewDelegate, RoomMenuDelegate {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var roomView: UIView!
    
    
    @IBOutlet var carpetImageView: UIImageView!
    @IBOutlet var shelfImageView: UIImageView!
    @IBOutlet var paintingImageView: UIImageView!
    @IBOutlet var bedImageView: UIImageView!
    @IBOutlet var tableImageView: UIImageView!
    @IBOutlet var merkyAPNGview: APNGImageView!
    @IBOutlet var roomMenuView: RoomMenu!
    
    @IBOutlet var menuButton: UIButton!
    
    
    var thingsArray = [Thing]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Pull Money but if on first run post $0 first
        if UserDefaults.standard.bool(forKey: "notFirstRun") == false {
            DataService.instance.postMoney(withUid: Auth.auth().currentUser!.uid, money: 0) {
                UserDefaults.standard.set(true, forKey: "notFirstRun")
                DataService.instance.getMoney(withUid: Auth.auth().currentUser!.uid) { (cash) in
                    Money.instance.money = cash
                }
                // Copy static home node from firebase
                DataService.instance.copyRoomData(withUid: Auth.auth().currentUser!.uid, homeNumber: "home1", completion: {
                    self.getRoomData()
                })
            }
        } else {
            DataService.instance.getMoney(withUid: Auth.auth().currentUser!.uid) { (cash) in
                Money.instance.money = cash
            }
            getRoomData()
        }
        
        

        //let animationUrL = URL(string: "https://firebasestorage.googleapis.com/v0/b/merklez-4cebe.appspot.com/o/room1%2Fezgif.com-apng-maker%20(1).png?alt=media&token=01009b5f-b5c1-4ebd-a845-7e8e4fa05284")
        
//        let animationUrL = URL(string: "https://firebasestorage.googleapis.com/v0/b/merklez-4cebe.appspot.com/o/room1%2Fezgif.com-apng-maker.png?alt=media&token=7104f31d-c91f-4e3c-8883-25205c24cbd6")
        
        let animationUrL = URL(string: "https://firebasestorage.googleapis.com/v0/b/merklez-4cebe.appspot.com/o/room1%2Fezgif.com-apng-maker%20(2).png?alt=media&token=da81387c-829a-4048-a486-4a3815dedad9")
        
        URLSession.shared.dataTask(with: animationUrL!) { (data, response, error) in
            
            if error != nil {
                print(error as Any)
                return
            }
            
            DispatchQueue.main.async {
                let animation = APNGImage(data: data!)
                //let animationView = APNGImageView(image: animation)
                self.merkyAPNGview.image = animation
                self.merkyAPNGview.startAnimating()
                
            }
        }.resume()

        
        roomMenuView.isHidden = true
        
        //FIREBASE SIGNOUT
//        do {
//            try Auth.auth().signOut()
//            print("you are logged out!!!!!!!!!!!!!")
//        } catch let logoutError {
//            print(logoutError)
//        }
        
        
        // ScrollView
        //scrollView.contentSize = roomView.bounds.size
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
        automaticallyAdjustsScrollViewInsets = false
        }
        
        // For Zooming
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2.0
        scrollView.zoomScale = 1.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getRoomData() {
        
        DataService.instance.getRoomData(withUid: Auth.auth().currentUser!.uid, homeNumber: "home1") { (things) in
            
            // HARD CODeD THE ROOM DATA, BAD!
            for thing in things {
                print(thing.name, "!!")
                print(thing.unlockable)
                if thing.bought == true {
                    if thing.name == "bed" {
                        self.bedImageView.loadImagesUsingCacheWithUrlString(urlString: thing.imageUrl)
                    } else if thing.name == "painting" {
                        self.paintingImageView.loadImagesUsingCacheWithUrlString(urlString: thing.imageUrl)
                    } else if thing.name == "shelf" {
                        self.shelfImageView.loadImagesUsingCacheWithUrlString(urlString: thing.imageUrl)
                    } else if thing.name == "carpet" {
                        self.carpetImageView.loadImagesUsingCacheWithUrlString(urlString: thing.imageUrl)
                    } else if thing.name == "table" {
                        self.tableImageView.loadImagesUsingCacheWithUrlString(urlString: thing.imageUrl)
                    }
                }
            }
        }
    }
    
    //Scroll View delegate for zooming
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return roomView
        
    }
    
    var roomMenuLauncher = RoomMenuLauncher()
    
    @IBAction func menuBtnPressed(_ sender: Any) {
        
        roomMenuLauncher.roomMenu.delegate = self
        
        roomMenuLauncher.showMenu()
        
    }
    
    func presentMoneyVC(){
        
        roomMenuLauncher.handleDismiss()
        
        let moneyVC = self.storyboard?.instantiateViewController(withIdentifier: "MoneyVC") as! MoneyVC
        present(moneyVC, animated: true, completion: nil)
    }
    
//    @IBAction func unwind(_ sender: UIStoryboardSegue){}
}

