//
//  CloseViewController.swift
//  Watoo
//
//  Created by Jay Shah on 10/10/15.
//  Copyright © 2015 Jay Shah. All rights reserved.
//

import UIKit
import Parse

class ClosetViewController: UIViewController,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource,UIPopoverPresentationControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let CELL_NAME="CategoryCell"
    let ITEM_CELL_NAME="ItemCell"
    
    @IBOutlet weak var tableView: UITableView!
   
    
    var catSelected = [-1,-1,-1]
    
    
    var selectedCategory:Int = 0
    
    //Parse code begin
    
    var closetCategories = [PFObject]()
    var closetItems = [[AnyObject]]()
    
    var printCategories = [Category]()
    var PFItems: [[PFObject]]?
    
    
    func addUser() {
        try! PFUser.currentUser()?.saveInBackground()
    }
    
   
    func add(newCategory: Category) {
        let PFCategory = PFObject(className: "Category")
        PFCategory["categoryName"] = newCategory.categoryName
        PFCategory["ownedBy"] = PFUser.currentUser()
        
        PFCategory.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("Saved new Category \(newCategory.categoryName)")
            } else {
                print("Error in Saving Category: \(error)")
                
                // There was a problem, check error.description
            }
        }
    }
    
 
    @IBAction func onCreateOutfit(sender: AnyObject) {
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("OutfitViewController") as! OutfitViewController
        
        var localOutfit = [PFFile]()
        if (catSelected[0] != -1){
            localOutfit.append (closetCategories[0]["items"][catSelected[0]] as! PFFile)
        } else {
            localOutfit.append(closetCategories[0]["items"][0] as! PFFile)
        }
        
        if (catSelected[1] != -1){
            localOutfit.append (closetCategories[1]["items"][catSelected[1]] as! PFFile)
        } else {
            localOutfit.append (closetCategories[1]["items"][0] as! PFFile)
        }
        
        if (catSelected[2] != -1){
            localOutfit.append (closetCategories[2]["items"][catSelected[2]] as! PFFile)
        }else {
            localOutfit.append (closetCategories[2]["items"][0] as! PFFile)
        }
        
        
        navController.outfitImages = localOutfit
        
        self.navigationController!.pushViewController(navController, animated: true)
    }
    
    
    func getCategories() {
        
        let query = PFQuery(className:"Category")
        query.findObjectsInBackgroundWithBlock {
            (categories: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // print("Successfully retrieved \(categories!.count) categories")
                if let categories = categories as [PFObject]? {
                    self.closetCategories = categories
                    
                    
                    for category in categories {
                        let catItems = category["items"]
                        if catItems != nil {
                            self.closetItems.append(catItems as! ([AnyObject]))
                        }
                        else{
                            self.closetItems.append([])
                        }
                    }
                    let user = PFUser.currentUser()
                    self.tableView.reloadData()
                }
               // for pfcategory in self.closetCategories {
               //     print(pfcategory["categoryName"])
                
               // }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func getItems() {
        let query = PFQuery(className:"Category")
        query.findObjectsInBackgroundWithBlock {
            (categories: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
              //  print("Successfully retrieved \(categories!.count) categories to fetch items")
                // Do something with the found objects
                if let categories = categories as [PFObject]? {
                    self.closetCategories = categories
                    
                    for category in categories{
                      var items = category["items"]
                        if (items == nil){
                            items = []
                        }
                        print (items)
                    }
                    
                    //print (categories[1].items)
                   // self.tableView.reloadData()
                   // self.PFItems?.append(items)
                   // print (self.PFItems)
                   // self.tableView.reloadData()
                }
               // print ("in getItems from categories")
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }

    
    // Parse code end
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return closetCategories.count ?? 0
    }
    
    func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_NAME) as! CategoryCell
       // cell.categoryLabel.text = categories[indexPath.row] as! NSString as String
       // cell.itemCollectionView.tag = indexPath.row
       // cell.photoButton.tag = indexPath.row

        let name = closetCategories[indexPath.row]["categoryName"]
        cell.categoryLabel.text = name as! String
        cell.itemCollectionView.tag = indexPath.row
        cell.photoButton.tag = indexPath.row
        cell.itemCollectionView.delegate = self
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      //  return items[collectionView.tag].count ?? 0
        return closetItems[collectionView.tag].count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var currentCategory = closetCategories[collectionView.tag]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        let profileImage = closetItems[collectionView.tag][indexPath.row] as? PFFile
        
        profileImage?.getDataInBackgroundWithBlock{
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.itemImageView.image = image
                }
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var collectonViewCount = collectionView.numberOfItemsInSection(0)
        
      //  for int i in 0..<collectonViewCount
      //  {
       //     collectionView.cellForItemAtIndexPath(i).alpha = 1
       // }
        
       // print ("I am selected \(indexPath) \(collectionView.tag)")
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell?.alpha = 0.6
        catSelected[collectionView.tag] = NSInteger(indexPath.row)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addUser()
        getCategories()
    }
    
    
    @IBAction func onPictureButton(sender: AnyObject) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .Alert)
        let cameraAction = UIAlertAction(title: "camera", style: .Default) { (action) -> Void in
            print("camera function is called here \(sender.tag)")
            self.selectedCategory = sender.tag
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .Camera
            self.presentViewController(picker, animated: true, completion: nil)
        }
        let albumAction = UIAlertAction(title: "album", style: .Default) { (action) -> Void in
            print("album function is called here \(sender.tag)")
            self.selectedCategory = sender.tag
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .PhotoLibrary
            self.presentViewController(picker, animated: true, completion: nil)
            
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .Default) { (action) -> Void in
            print("cancel function is called here")
        }
        alertController.addAction(cameraAction)
        alertController.addAction(albumAction)
        alertController.addAction(cancelAction)
        
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PhotoSelectViewController") as! PhotoSelectViewController
        let selectedCategoryLabel = closetCategories[selectedCategory]["categoryName"] as! String
        navController.inputCategoryIndex = selectedCategory
        navController.inputCategories = closetCategories
        navController.inputPhotoCategory = selectedCategoryLabel
        navController.inputPhotoImage = selectedImage
        navController.inputCategoryTag = selectedCategory
 
        self.navigationController!.pushViewController(navController, animated: true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}


class CategoryCell:UITableViewCell{
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    @IBOutlet weak var photoButton: UIButton!
}


class ItemCell:UICollectionViewCell{
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
}