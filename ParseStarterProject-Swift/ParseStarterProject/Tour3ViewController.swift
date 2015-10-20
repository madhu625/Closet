//
//  Tour3ViewController.swift
//  Watoo
//
//  Created by Jay Shah on 10/20/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class Tour3ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)

        //------------right  swipe gestures in view--------------//
        let swipeRight = UISwipeGestureRecognizer(target: self, action: Selector("rightSwiped"))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        //-----------left swipe gestures in view--------------//
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector("leftSwiped"))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        
        // Do any additional setup after loading the view.
    }
    
    func rightSwiped() {
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Tour2ViewController") as UIViewController
        navController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
    func leftSwiped() {
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ViewController") as UIViewController
        navController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
