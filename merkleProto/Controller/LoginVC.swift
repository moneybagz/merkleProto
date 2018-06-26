//
//  LoginVC.swift
//  merkleProto
//
//  Created by Clyfford Millet on 6/13/18.
//  Copyright © 2018 Clyff Millet. All rights reserved.
//

import UIKit
import Firebase

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
    
    //Saving username and password
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
                    if let error = loginError {
                        self.authenticationFailAlert(error: error)
                    }
                }
            }
        }
    }
    
    func authenticationFailAlert(error: Error) {
        
        if error._code == AuthErrorCode.userNotFound.rawValue {
            let alert = UIAlertController(title: "Creating New User", message: (String(describing: error.localizedDescription)), preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { action in
                self.registerUser()
            }
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        
        let alert = UIAlertController(title: "error", message: (String(describing: error.localizedDescription)), preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func registerUser() {
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
                if let error = registrationError {
                    print(String(describing: error.localizedDescription))
                    self.authenticationFailAlert(error: error)
                }
            }
        })
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
