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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if Auth.auth().currentUser == nil {
            print("current user doesnt exists")
        }
        if Auth.auth().currentUser?.uid == nil {
            print("uid doesnt exist")
        }
        
        DataService.instance.getTimeStamp(withUID: Auth.auth().currentUser!.uid) { (timeStamp) in
            //print("\(timeStamp)!!!!!!!!!!!!!!")
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
