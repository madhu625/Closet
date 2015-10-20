
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
    
    @IBOutlet weak var accessoryImageView: UIImageView!
    @IBOutlet weak var shirtImageView: UIImageView!
    @IBOutlet weak var pantsImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.outfitImages = ["http://ep.yimg.com/ay/stylinonline/star-wars-here-comes-trouble-youth-t-shirt-5.jpg","http://www.senecahs.org/vimages/shared/vnews/stories/54d37da28bc2f/1_jeans.jpg", "http://nsrgtrading.com/wp-content/uploads/2014/09/66.jpg"]
        
        
        self.outfitImages![0].getDataInBackgroundWithBlock{
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    self.accessoryImageView.image = image
                }
            }
        }
        
    }
    
    func loadImages() {

        self.outfitImages![1].getDataInBackgroundWithBlock{
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    self.shirtImageView.image = image
                }
            }
        }
        
        self.outfitImages![2].getDataInBackgroundWithBlock{
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    self.pantsImageView.image = image
                }
            }
        }
        
    }
    
    func fetchImagesRandomly() {
        
        //        ParseClient.sharedInstance.fetchRandomOutfit() {
        //
        //        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func saveOutFits(sender: UIButton) {
        
        var pfOutFits = PFObject(className:"outfits")
        pfOutFits["outfitImages"] = self.outfitImages
        pfOutFits.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("Saved outfits")
            } else {
                // There was a problem, check error.description
            }
        }
        
    }
}
