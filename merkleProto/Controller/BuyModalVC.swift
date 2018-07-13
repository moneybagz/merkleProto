//
//  BuyModalVC.swift
//  merkleProto
//
//  Created by Clyfford Millet on 6/28/18.
//  Copyright © 2018 Clyff Millet. All rights reserved.
//

import UIKit
import Firebase

class BuyModalVC: UIViewController {
    
    
    @IBOutlet var buyLabel: UILabel!
    
    var thing: Thing?
    
    func initData(forThing thing: Thing) {
        self.thing = thing
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let thing = thing {
            buyLabel.text = "Purchase \(thing.name)?"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buyBtn(_ sender: Any) {
        if let thing = thing {
            if thing.cost <= Money.instance.money! {
                DataService.instance.buyThings(withUid: Auth.auth().currentUser!.uid, roomNumber: "room1", thing: thing, money: Money.instance.money! - thing.cost) {
                    
                    Money.instance.money! -= thing.cost
                    
                    //update collection view ui
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

                    self.dismiss(animated: false, completion: nil)
                }                
            }
        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
