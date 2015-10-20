//
//  BaseViewController.swift
//  twitter
//
//  Created by Jay Shah on 10/5/15.
//  Copyright © 2015 Jay Shah. All rights reserved.
//

import UIKit
import Parse

class BaseViewController: UIViewController {
    
    @IBOutlet weak var sidePanelView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    var sidePanelPriginalCenter: CGPoint!
    
    //assgin nav controller to the content viewView
    let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ViewController") as UIViewController
    
    let  closetController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CategoryNavigationController") as UIViewController
    
    let tourController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Tour1ViewController") as UIViewController
    
    let outfitColletionController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ShowOutFitsCollectionViewController") as UIViewController
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        contentView = navController.view
        self.view.addSubview(contentView)
        self.view.bringSubviewToFront(contentView)
        
        addChildViewController(navController)
        navController.didMoveToParentViewController(self)
        
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        print("hello")
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickCloset(sender: AnyObject) {
        
        contentView = closetController.view
        
        self.view.addSubview(contentView)
        self.view.bringSubviewToFront(contentView)
        
        addChildViewController(closetController)
        closetController.didMoveToParentViewController(self)
        self.hideSidePanel();
    }
    
    
    @IBAction func onClickOutfits(sender: AnyObject) {
        
        contentView = outfitColletionController.view
        self.view.addSubview(contentView)
        self.view.bringSubviewToFront(contentView)
        
        addChildViewController(outfitColletionController)
        outfitColletionController.didMoveToParentViewController(self)
        self.hideSidePanel();
        
    }
    
    @IBAction func onClickHome(sender: AnyObject) {
        PFUser.logOut()
        var currentUser = PFUser.currentUser()
        
        contentView = navController.view
        self.view.addSubview(contentView)
        self.view.bringSubviewToFront(contentView)
        
        addChildViewController(navController)
        navController.didMoveToParentViewController(self)
        
        self.hideSidePanel();
        
        
    }

    
    @IBAction func onClickLogout(sender: AnyObject) {
        PFUser.logOut()
        var currentUser = PFUser.currentUser()
        
        contentView = navController.view
        self.view.addSubview(contentView)
        self.view.bringSubviewToFront(contentView)
        
        addChildViewController(navController)
        navController.didMoveToParentViewController(self)
        
        self.hideSidePanel();
        
        
    }

    
    @IBAction func onClickTour(sender: AnyObject) {
        
        contentView = tourController.view
        self.view.addSubview(contentView)
        self.view.bringSubviewToFront(contentView)
        
        addChildViewController(tourController)
        tourController.didMoveToParentViewController(self)
        
        self.hideSidePanel();
        

    }
    func hideSidePanel () {
        sidePanelView.frame = CGRectMake(0,0,0,0) //CGRectMake(0, 0 ,sidePanelView.frame.width, sidePanelView.frame.height)
        contentView.frame = CGRectMake(0, 0, contentView.frame.width, contentView.frame.height)
        self.view.bringSubviewToFront(contentView)
        
    }
    
    func onCustomPan(panGestureRecognizer: UIPanGestureRecognizer) {
        
        let velocity = panGestureRecognizer.velocityInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            // println("Gesture began at: \(point)")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            //println("Gesture changed at: \(point)")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            //println("Gesture ended at: \(point)")
            if (velocity.x > 0) {
                sidePanelView.frame = CGRectMake(0, 0, sidePanelView.frame.width, sidePanelView.frame.height)
                contentView.frame = CGRectMake(sidePanelView.frame.width, 0, contentView.frame.width, contentView.frame.height)
                self.view.bringSubviewToFront(sidePanelView)
                
            } else {
                sidePanelView.frame = CGRectMake(0,0,0,0) //CGRectMake(0, 0 ,sidePanelView.frame.width, sidePanelView.frame.height)
                contentView.frame = CGRectMake(0, 0, contentView.frame.width, contentView.frame.height)
                self.view.bringSubviewToFront(contentView)
                
            }
        }
    }
    
    @IBAction func onPanGesture(sender: AnyObject) {
        
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
