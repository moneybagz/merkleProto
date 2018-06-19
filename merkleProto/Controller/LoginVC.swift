//
//  LoginVC.swift
//  merkleProto
//
//  Created by Clyfford Millet on 6/13/18.
//  Copyright © 2018 Clyff Millet. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet var emailField: UITextField!    
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var rememberMeBtn: UIButton!
    
    
    var rememberMe: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //Automatic text fill
        if UserDefaults.standard.string(forKey: "email") != nil && UserDefaults.standard.string(forKey: "password") != nil {
            emailField.text = UserDefaults.standard.string(forKey: "email")
            passwordField.text = UserDefaults.standard.string(forKey: "password")
        }
    }
    
    @IBAction func rememberMeBtnPressed(_ sender: Any) {
        if rememberMe == false {
            rememberMe = true
            rememberMeBtn.backgroundColor = UIColor.red
        } else {
            rememberMe = false
            rememberMeBtn.backgroundColor = UIColor.cyan
        }
    }
    
    @IBAction func SignInBtnPressed(_ sender: Any) {
        if emailField.text != nil && passwordField.text != nil {
            AuthService.instance.loginUser(withEmail: emailField.text!, andPassword: passwordField.text!) { (success, loginError) in
                if success {
                    
                    // Saving email and password
                    if self.rememberMe == true {
                        UserDefaults.standard.set(self.emailField.text, forKey: "email")
                        UserDefaults.standard.set(self.passwordField.text, forKey: "password")
                    }
                    
                    //self.dismiss(animated: true, completion: nil)
                    let RoomVC = self.storyboard?.instantiateViewController(withIdentifier: "RoomVC") as! RoomVC
                    self.present(RoomVC, animated: true, completion: nil)
                    
                } else {
                    print(String(describing: loginError?.localizedDescription))
                }
                
                AuthService.instance.registerUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, userCreationComplete: { (success, registrationError) in
                    if success {
                        AuthService.instance.loginUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, loginComplete: { (success, registrationError) in
                            
                            // Saving email and password
                            if self.rememberMe == true {
                                UserDefaults.standard.set(self.emailField.text, forKey: "email")
                                UserDefaults.standard.set(self.passwordField.text, forKey: "password")
                            }
                            
                            //self.dismiss(animated: true, completion: nil)
                            let RoomVC = self.storyboard?.instantiateViewController(withIdentifier: "RoomVC") as! RoomVC
                            self.present(RoomVC, animated: true, completion: nil)
                        })
                        
                    } else {
                        print(String(describing: registrationError?.localizedDescription))
                    }
                })
            }
        }
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
