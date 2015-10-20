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
    var outFitNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Printing fetched array")
        for (name, _) in self.fetchedOutFitImagesDict{
            print(name)
            self.outFitNames.append(name)
        }
        
        //self.outFitNames = self.fetchedOutFitImagesDict.keys as! String
        //print(self.outFitNames)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //  return items[collectionView.tag].count ?? 0
        return self.fetchedOutFitImagesDict.count
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
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

