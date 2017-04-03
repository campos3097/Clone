//
//  SignInVc.swift
//  Rider
//
//  Created by Bryant Acosta on 3/2/17.
//  Copyright © 2017 Bryant Acosta. All rights reserved.
//

import UIKit
import FirebaseAuth


class SignInVc: UIViewController {
    
    private let RIDER_SEGUE = "RiderVc"
    
    

    @IBOutlet weak var emailTxt: UITextField!

    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

   
    }

    @IBAction func LogIn(_ sender: Any) {

        
        
        if emailTxt.text != "" && passwordTxt.text != "" {
            
            AuthProvider.Instance.login(withEmail: emailTxt.text!, password: passwordTxt.text!, loginHandler: { (message) in
                
                if message != nil {
                    self.alertTheUser(title: "Problem With Authentacation ", message: message!);
                }else {
                    uberHandler.Instance.rider = self.emailTxt.text!;
                    
                    self.emailTxt.text = "";
                    self.passwordTxt.text = "";
                    
                    self.performSegue(withIdentifier: self.RIDER_SEGUE, sender: nil);
                }
                
                
                    
            });
        }else{
            alertTheUser(title: "Email And Password Are Required", message: "Please Enter Email and Password in the text field");
        }
        
        
        }
   @IBAction func SignUp(_ sender: Any) {
    
    if emailTxt.text! != "" && passwordTxt.text! != "" {
        AuthProvider.Instance.signUp(withEmail: emailTxt.text!, password: passwordTxt.text!, loginHandler: { (message) in
               if message != nil {
                self.alertTheUser(title: "Problem With Creating A New User", message: message!);
            } else {
                uberHandler.Instance.rider = self.emailTxt.text!;
                self.emailTxt.text = "";
                self.passwordTxt.text = "";

                self.performSegue(withIdentifier: self.RIDER_SEGUE, sender: nil);

                 
            }
            
        });
        
        
    }else{
        alertTheUser(title: "Email And Password Are Required", message: "Please Enter Email and Password in the text field");
        
        }
    }
    
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
        
        
        
        
   
    }
} // class





















