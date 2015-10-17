//
//  CloseViewController.swift
//  Watoo
//
//  Created by Jay Shah on 10/10/15.
//  Copyright © 2015 Jay Shah. All rights reserved.
//

import UIKit

class ClosetViewController: UIViewController,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource,UIPopoverPresentationControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let CELL_NAME="CategoryCell"
    let ITEM_CELL_NAME="ItemCell"
    
    let categories: NSArray = ["Shirts", "Pants", "Accessories"]
    let items: NSArray = [["Shirt1", "Shirt2", "Shirt3"],["Pant1", "Pant2", "Pant3", "Pant4"],["Shoe1", "Shoe2", "Shoe3", "Shoe4", "Shoe5"] ]
    
    var selectedCategory:Int = 0
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count ?? 0
    }
    
    func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_NAME) as! CategoryCell
        cell.categoryLabel.text = categories[indexPath.row] as! NSString as String
        cell.itemCollectionView.tag = indexPath.row
        cell.photoButton.tag = indexPath.row
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[collectionView.tag].count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        cell.itemLabel.text = items[collectionView.tag][indexPath.row] as! NSString as String
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onPictureButton(sender: AnyObject) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .Alert)
        let cameraAction = UIAlertAction(title: "camera", style: .Default) { (action) -> Void in
            print("camera function is called here \(sender.tag)", terminator: "")
            self.selectedCategory = sender.tag
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .Camera
            self.presentViewController(picker, animated: true, completion: nil)
        }
        let albumAction = UIAlertAction(title: "album", style: .Default) { (action) -> Void in
            print("album function is called here \(sender.tag)", terminator: "")
            self.selectedCategory = sender.tag
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .PhotoLibrary
            self.presentViewController(picker, animated: true, completion: nil)
            
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .Default) { (action) -> Void in
            print("cancel function is called here", terminator: "")
        }
        alertController.addAction(cameraAction)
        alertController.addAction(albumAction)
        alertController.addAction(cancelAction)
        
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("hello")
        let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PhotoSelectViewController") as! PhotoSelectViewController
        print (selectedCategory, terminator: "")
        
        let selectedCategoryLabel = categories[selectedCategory] as! NSString as String
        print (selectedCategoryLabel, terminator: "")
        
        
        navController.inputPhotoCategory = selectedCategoryLabel
        navController.inputPhotoImage = selectedImage
        navController.inputCategoryTag = selectedCategory
        
        self.navigationController?.pushViewController(navController, animated: false)
        
        self.dismissViewControllerAnimated(true){}
        
    }
    
}


class CategoryCell:UITableViewCell{
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    @IBOutlet weak var photoButton: UIButton!
}


class ItemCell:UICollectionViewCell{
    @IBOutlet weak var itemLabel: UILabel!
}