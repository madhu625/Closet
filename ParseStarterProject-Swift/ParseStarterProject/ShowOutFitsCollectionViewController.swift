//
//  ShowOutFitsCollectionViewController.swift
//  Watoo
//
//  Created by Ravinder Matte on 10/20/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ShowOutFitsCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var fetchedOutFitImagesDict = [String:[PFFile]]()
    
    @IBOutlet var collectionView: UICollectionView!
    var outFitNames = [String]()
    
    func fetchOldOutfits() {
        let query = PFQuery(className:"outfits")
        // query.orderByDescending("outfitName")
        query.findObjectsInBackgroundWithBlock { (outFitObjects: [PFObject]?, error: NSError?) -> Void in
            if error == nil && outFitObjects != nil {
                for outFitObject in outFitObjects! {
                    if let outFitName = outFitObject["outfitName"] as? String {
                        let outFit = outFitObject["outfitImages"] as! [PFFile]
                        self.fetchedOutFitImagesDict[outFitName] = outFit
                    }
                }
                for (name, _) in self.fetchedOutFitImagesDict{
                    self.outFitNames.append(name)
                }
                self.collectionView.reloadData()
            } else {
                print(error)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchOldOutfits()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchedOutFitImagesDict.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("OutFitCell", forIndexPath: indexPath) as! OutFitCellCollectionViewCell
        
        let outFitName = self.outFitNames[indexPath.row]
        cell.OutFitLabel.text = outFitName
        let outfits = self.fetchedOutFitImagesDict[outFitName]
        
        outfits![0].getDataInBackgroundWithBlock{
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.accessoryImageView.image = image
                }
            }
        }
        
        
        outfits![1].getDataInBackgroundWithBlock{
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.shirtImageView.image = image
                }
            }
        }
        
        outfits![2].getDataInBackgroundWithBlock{
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.pantsImageView.image = image
                }
            }
        }
        return cell
    }
    
}
