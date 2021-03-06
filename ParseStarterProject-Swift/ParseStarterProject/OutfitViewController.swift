
//  OutfitViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Deepti Chinta on 10/17/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class OutfitViewController: UIViewController {
    
    var outfitImages: [PFFile]?
    var fetchedOutFitImagesDict = [String:[PFFile]]()
    
    @IBOutlet weak var outFitNameTextField: UITextField!
    @IBOutlet weak var accessoryImageView: UIImageView!
    @IBOutlet weak var shirtImageView: UIImageView!
    @IBOutlet weak var pantsImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showOutFit(self.outfitImages)
        //fetchOldOutfits()
    }
    
    
    
    func showOutFit(outfits: [PFFile]?) {
        outfits![0].getDataInBackgroundWithBlock{
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    self.accessoryImageView.image = image
                }
            }
        }
        
        
        outfits![1].getDataInBackgroundWithBlock{
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    self.shirtImageView.image = image
                }
            }
        }
        
        outfits![2].getDataInBackgroundWithBlock{
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    self.pantsImageView.image = image
                }
            }
        }
        
    }
    
    
    @IBAction func showPreviousOutfits(sender: UIButton) {
        let navVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ShowOutFitsCollectionViewController") as! ShowOutFitsCollectionViewController
        
       // navVC.fetchedOutFitImagesDict = self.fetchedOutFitImagesDict
        self.navigationController!.pushViewController(navVC, animated: true)
    }
    
    func fetchOldOutfits() {
        let query = PFQuery(className:"outfits")
        query.findObjectsInBackgroundWithBlock { (outFitObjects: [PFObject]?, error: NSError?) -> Void in
            if error == nil && outFitObjects != nil {
               // print(outFitObjects)
                for outFitObject in outFitObjects! {
                    if let outFitName = outFitObject["outfitName"] as? String {
                        let outFit = outFitObject["outfitImages"] as! [PFFile]
                       // print("Adding \(outFitName)")
                        self.fetchedOutFitImagesDict[outFitName] = outFit
                    }
                }
            } else {
                print(error)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func saveOutFits(sender: UIButton) {
        let pfOutFits = PFObject(className:"outfits")
        pfOutFits["outfitName"] = self.outFitNameTextField.text
        pfOutFits["outfitImages"] = self.outfitImages
        pfOutFits.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("Saved outfits")
                self.outFitNameTextField.text = ""
            } else {
                // There was a problem, check error.description
            }
        }
        
    }
}
















