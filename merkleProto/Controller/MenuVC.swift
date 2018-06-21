//
//  MenuViewController.swift
//  merkleProto
//
//  Created by Clyfford Millet on 6/9/18.
//  Copyright © 2018 Clyff Millet. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        let roomVC = self.storyboard?.instantiateViewController(withIdentifier: "RoomVC") as! RoomVC
        present(roomVC, animated: true, completion: nil)
    }
    
    @IBAction func moneyBtnPressed(_ sender: Any) {
        let moneyVC = self.storyboard?.instantiateViewController(withIdentifier: "MoneyVC") as! MoneyVC
        present(moneyVC, animated: true, completion: nil)
    }
    
    @IBAction func shopBtnPressed(_ sender: Any) {
        let shopVC = self.storyboard?.instantiateViewController(withIdentifier: "ShopVC") as! ShopVC
        present(shopVC, animated: true, completion: nil)
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
