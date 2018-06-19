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
    @IBOutlet var moneyLabel: UILabel!
    
    var timeStampOne: NSNumber?
    var timeStampTwo: NSNumber?
    
    var countdownTimer: Timer?
    var totalTime: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moneyLabel.text = "\(String(describing: Money.instance.money!))"
        
        //so countdownTimer won't be called twice doubling its time
        NotificationCenter.default.addObserver(self, selector: #selector(resetTotalTime), name: Notification.Name.UIApplicationDidEnterBackground, object: nil)
        // Notifications that handle timer when going to background state
        NotificationCenter.default.addObserver(self, selector: #selector(getTimeStamps), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
        
        getMoneyBtn.isHidden = UserDefaults.standard.bool(forKey: "hidden")

        getTimeStamps()
    }
    
    
    @objc func getTimeStamps() {
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
                    // if from backgroundstate timer has elaspsed, reset timelabel
                    self.timeLabel.text = ""
                    
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
            countdownTimer?.invalidate()
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
    
    @objc func resetTotalTime() {
        if countdownTimer != nil {
            countdownTimer?.invalidate()
        }
    }

    
    @IBAction func getMoneyBtnPressed(_ sender: Any) {
        
        // Use completion block to call get after push has been completed
        DataService.instance.createTimeStamp(withUid: Auth.auth().currentUser!.uid) {
            
            self.getMoneyBtn.isHidden = true
            
            // button hidden persistence
            UserDefaults.standard.set(self.getMoneyBtn.isHidden, forKey: "hidden")
            
            self.getTimeStamps()
        }
        
        randomMoney()
    }
    
    func randomMoney() {
        var number = Int(arc4random_uniform(5))
        
        switch number {
        case 0:
            number = 25
        case 1:
            number = 25
        case 2:
            number = 50
        case 3:
            number = 50
        case 4:
            number = 100
        default:
            number = 777
        }

        if Money.instance.money != nil {
            number += Money.instance.money!
        }
        
        DataService.instance.postMoney(withUid: Auth.auth().currentUser!.uid, money: number) {
            DataService.instance.getMoney(withUid: Auth.auth().currentUser!.uid, handler: { (cash) in
                Money.instance.money = cash
                self.moneyLabel.text = String(Money.instance.money!)
            })
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
