//
//  ParseLoginViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Ravinder Matte on 10/11/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ParseLoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("in parse login view controller")
        
        saveCategories()
        
    }
    
    func saveCategories(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func parseSignup(sender: UIButton) {
        let user = PFUser()
        user.username = emailTextField.text
        user.password = passwordTextField.text
        user.email = emailTextField.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                    print(errorString!)
                
            } else {
                // Hooray! Let them use the app now.
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    @IBAction func parseLogin(sender: UIButton) {
        
        PFUser.logInWithUsernameInBackground(emailTextField.text!, password:passwordTextField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("You are in")
                self.dismissViewControllerAnimated(true, completion: nil)
                
            } else {
                let errorString = error!.userInfo["error"] as? NSString
                print(errorString!)
                
            }
        }
    }
    

    
}
