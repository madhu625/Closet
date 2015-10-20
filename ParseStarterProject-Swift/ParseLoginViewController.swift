//
//  ViewController.swift
//  chatclient
//
//  Created by Jay Shah on 9/24/15.
//  Copyright © 2015 Jay Shah. All rights reserved.
//

import UIKit
import Parse

class ParseLoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func clickSignInButton(sender: AnyObject) {
        
        let user = PFUser()
        
        user.username = passwordField.text
        user.password = passwordField.text
        user.email = emailField.text
        
        PFUser.logInWithUsernameInBackground(user.username!, password:user.password!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CategoryNavigationController") as UIViewController
                
                self.presentViewController(navController, animated: true, completion: nil)

                
            } else {
                // The login failed. Check error to see why.
                let errorString = error!.userInfo["error"] as? String
                self.showAlert("SignIn Failed", message: errorString!)
                
            }
        }
        
    }
    @IBAction func clickSignUpButton(sender: AnyObject) {
        
        let user = PFUser()
        
        user.username = emailField.text
        user.password = passwordField.text
        user.email = emailField.text
        
        if (user.username != nil &&  user.password != nil && user.email != nil) {
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if let error = error {
                    let errorString = error.userInfo["error"] as? String
                    
                    self.showAlert("SignUp Failed", message: errorString!)
                    
                } else {
                    // Hooray! Let them use the app now.
                    print("you just signed up", terminator: "")
                    
                    let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CategoryNavigationController") as UIViewController
                    
                    self.presentViewController(navController, animated: true, completion: nil)

                }
            }
        }
    }
    
    func showAlert (title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

