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

    @IBAction func getMoneyBtnPressed(_ sender: Any) {
        DataService.instance.createTimeStamp(withUid: (Auth.auth().currentUser?.uid)!)
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
