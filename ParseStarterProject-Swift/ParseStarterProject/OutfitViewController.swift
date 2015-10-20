
//
//  OutfitViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Deepti Chinta on 10/17/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class OutfitViewController: UIViewController {
    
    var outfitImages: [AnyObject]?
    
    @IBOutlet weak var alphaImageView: UIImageView!
    @IBOutlet weak var betaImageView: UIImageView!
    @IBOutlet weak var deltaImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.outfitImages = ["http://ep.yimg.com/ay/stylinonline/star-wars-here-comes-trouble-youth-t-shirt-5.jpg","http://www.senecahs.org/vimages/shared/vnews/stories/54d37da28bc2f/1_jeans.jpg", "http://nsrgtrading.com/wp-content/uploads/2014/09/66.jpg"]
//        
//        // Do any additional setup after loading the view.
        
        if outfitImages != nil {
            self.loadImages()
        } else {
            self.fetchImagesRandomly()
        }
        
    }
    
    func loadImages() {
        switch(self.outfitImages!.count){
        case 1:
            alphaImageView.setImageWithURL(NSURL(string: self.outfitImages![0])!)
        case 2:
            alphaImageView.setImageWithURL(NSURL(string: self.outfitImages![0])!)
            betaImageView.setImageWithURL(NSURL(string: self.outfitImages![1])!)
            
        case 3:
            alphaImageView.setImageWithURL(NSURL(string: self.outfitImages![0])!)
            betaImageView.setImageWithURL(NSURL(string: self.outfitImages![1])!)
            deltaImageView.setImageWithURL(NSURL(string: self.outfitImages![2])!)
            
        default:
            print("do nothing")
            
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
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
