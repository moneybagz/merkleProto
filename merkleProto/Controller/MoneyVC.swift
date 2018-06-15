//
//  MoneyVC.swift
//  merkleProto
//
//  Created by Clyfford Millet on 6/13/18.
//  Copyright © 2018 Clyff Millet. All rights reserved.
//

import UIKit
import Firebase

class MoneyVC: UIViewController {
    
    var timeStampOne: NSNumber?
    var timeStampTwo: NSNumber?

    override func viewDidLoad() {
        super.viewDidLoad()

        DataService.instance.getTimeStamp(withUID: Auth.auth().currentUser!.uid) { (timeStamp) in
            self.timeStampOne = timeStamp
            
            self.timeComparison()
        }
    }
    
    func timeComparison() {
        DataService.instance.createSecondTimeStamp(withUid: Auth.auth().currentUser!.uid)
        
        DataService.instance.getSecondTimeStamp(withUID: Auth.auth().currentUser!.uid) { (secondTimeStamp) in
            self.timeStampTwo = secondTimeStamp
            
            //Convert NSNumber to int64 to do math
            let timeOneInt = self.timeStampOne?.int64Value
            let timeTwoInt = self.timeStampTwo?.int64Value
            
            print("\(String(describing: timeTwoInt)) - \(String(describing: timeOneInt)) = \(timeTwoInt! - timeOneInt!)")
            let range = timeTwoInt! - timeOneInt!
            //Get rid of miliseconds
            let seconds = range / 1000
            print("\(seconds)@@@@@@")
        }
    }
    
    @IBAction func getMoneyBtnPressed(_ sender: Any) {
        
        DataService.instance.createTimeStamp(withUid: Auth.auth().currentUser!.uid)
    
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
