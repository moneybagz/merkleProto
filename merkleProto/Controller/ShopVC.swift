//
//  ShopVC.swift
//  merkleProto
//
//  Created by Clyfford Millet on 6/20/18.
//  Copyright © 2018 Clyff Millet. All rights reserved.
//

import UIKit
import Firebase

class ShopVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collection: UICollectionView!
    
    var thingsArray = [Thing]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // reload data after modal view is dismissed
        NotificationCenter.default.addObserver(self, selector: #selector(loadDataFromObserver), name: NSNotification.Name(rawValue: "load"), object: nil)

        collection.dataSource = self
        collection.delegate = self
        
        DataService.instance.getRoomData(withUid: Auth.auth().currentUser!.uid, homeNumber: "home1") { (things) in
            for thing in things {
                if thing.access == true {
                    self.thingsArray.append(thing)
                }
            }
            self.collection.reloadData()
        }
    }
    
    @objc func loadDataFromObserver(){
        //load data here
        thingsArray.removeAll()
        DataService.instance.getRoomData(withUid: Auth.auth().currentUser!.uid, homeNumber: "home1") { (things) in
            for thing in things {
                if thing.access == true {
                    self.thingsArray.append(thing)
                }
            }
            self.collection.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as? ShopCell {
            
            let thing = thingsArray[indexPath.row]
            cell.configureCell(thing: thing)
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let thing = thingsArray[indexPath.row]
        
        let buyModalVC = self.storyboard?.instantiateViewController(withIdentifier: "BuyModalVC") as! BuyModalVC
        buyModalVC.initData(forThing: thing)
        buyModalVC.providesPresentationContextTransitionStyle = true
        buyModalVC.definesPresentationContext = true
        buyModalVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
        buyModalVC.view.backgroundColor = UIColor.init(white: 0.2, alpha: 0.5)
        buyModalVC.modalTransitionStyle = .crossDissolve
        
        self.present(buyModalVC, animated: true, completion: nil)    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thingsArray.count
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
