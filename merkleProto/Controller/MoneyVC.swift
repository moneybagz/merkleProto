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
    
    @IBOutlet var getMoneyBtn: UIButton!
    @IBOutlet var timeLabel: UILabel!
    
    var timeStampOne: NSNumber?
    var timeStampTwo: NSNumber?
    
    var countdownTimer: Timer!
    var totalTime: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMoneyBtn.isHidden = UserDefaults.standard.bool(forKey: "hidden")

        getTimeStamps()
    }
    
    func getTimeStamps() {
        if UserDefaults.standard.bool(forKey: "hidden") == true {
            DataService.instance.getTimeStamp(withUID: Auth.auth().currentUser!.uid) { (timeStamp) in
                self.timeStampOne = timeStamp
                
                self.timeComparison()
            }
        } else { return }
    }
    
    func timeComparison() {
        DataService.instance.createSecondTimeStamp(withUid: Auth.auth().currentUser!.uid) {
        
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
                
                //User can get money after 15 minutes expires
                if seconds > 90 {
                    self.getMoneyBtn.isHidden = false
                    
                    UserDefaults.standard.set(self.getMoneyBtn.isHidden, forKey: "hidden")
                } else {
                    self.totalTime = Int(90 - seconds)
                    self.startTimer()
                }
            }
        }
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self,      selector: #selector(self.updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        timeLabel.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            countdownTimer.invalidate()
            timeLabel.text = ""
            getMoneyBtn.isHidden = false
            UserDefaults.standard.set(self.getMoneyBtn.isHidden, forKey: "hidden")
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @IBAction func getMoneyBtnPressed(_ sender: Any) {
        
        // Use completion block to call get after push has been completed
        DataService.instance.createTimeStamp(withUid: Auth.auth().currentUser!.uid) {
            
            self.getMoneyBtn.isHidden = true
            
            // button hidden persistence
            UserDefaults.standard.set(self.getMoneyBtn.isHidden, forKey: "hidden")
            
            self.getTimeStamps()
        }
    
        
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
