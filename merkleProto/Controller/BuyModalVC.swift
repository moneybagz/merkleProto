//
//  BuyModalVC.swift
//  merkleProto
//
//  Created by Clyfford Millet on 6/28/18.
//  Copyright © 2018 Clyff Millet. All rights reserved.
//

import UIKit

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
