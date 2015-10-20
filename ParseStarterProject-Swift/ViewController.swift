//
//  ViewController.swift
//  Watoo
//
//  Created by Jay Shah on 10/10/15.
//  Copyright © 2015 Jay Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var wearToday: UIImageView!
    @IBOutlet weak var loginButton: UIImageView!
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var leftHRLabel: UIView!
    @IBOutlet weak var rightHRLabel: UIView!
    @IBOutlet weak var orLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loginButton.alpha = 0
        self.guestButton.alpha = 0
        self.leftHRLabel.alpha = 0
        self.orLabel.alpha = 0
        self.rightHRLabel.alpha = 0
        self.wearToday.alpha = 0
        
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
       
        self.wearToday.frame = CGRect(x: -20,y: 185, width: self.wearToday.frame.size.width, height: self.wearToday.frame.size.height)
        
         self.guestButton.frame = CGRect(x: (self.view.frame.size.width/2) - (self.guestButton.frame.size.width/2), y: self.view.frame.size.height + 100, width: self.guestButton.frame.size.width, height: self.guestButton.frame.size.height)
        
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            self.logo.alpha = 1.0
            
            }) { (Bool) -> Void in
                
                UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.5, options: UIViewAnimationOptions.AllowUserInteraction , animations: { () -> Void in
                    
                    
                    self.logo.frame = CGRect(x: self.logo.frame.origin.x, y: 120, width: self.logo.frame.size.width, height: self.logo.frame.size.height)
                    
                    
                    
                    }, completion: { (Bool) -> Void in
                        
                        self.guestButton.alpha = 1
                        
                        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.5, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                            
                            self.wearToday.alpha = 1
                            self.wearToday.frame = CGRect(x: (self.view.frame.size.width/2) - (self.wearToday.frame.size.width/2), y: 185, width: self.wearToday.frame.size.width, height: self.wearToday.frame.size.height)
                            
                            self.guestButton.frame = CGRect(x: (self.view.frame.size.width/2) - (self.guestButton.frame.size.width/2), y: 500, width: self.guestButton.frame.size.width, height: self.guestButton.frame.size.height)
                            
                            }, completion: { (Bool) -> Void in
                                
                        })
                        
                        
                        self.loginButton.alpha = 1
                        self.loginButton.transform = CGAffineTransformMakeScale(0.8, 0.8)
                        
                        UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                            
                            self.loginButton.transform = CGAffineTransformMakeScale(1.25, 1.25)
                            
                            }, completion: {(Bool) -> Void in
                                
                                UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                                    
                                    self.loginButton.transform = CGAffineTransformIdentity
                                    }, completion: nil)
                        })
                        
                        
                        
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            
                            self.leftHRLabel.alpha = 1
                            self.orLabel.alpha = 1
                            self.rightHRLabel.alpha = 1
                            
                        })
                        
                        
                })
                
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
