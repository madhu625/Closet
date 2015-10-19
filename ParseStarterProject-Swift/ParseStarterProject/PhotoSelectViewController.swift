//
//  PhotoSelectViewController.swift
//  CollectionTableApp
//
//  Created by Deepti Chinta on 10/13/15.
//  Copyright © 2015 DeeptiChinta. All rights reserved.
//

import UIKit
import Parse


class PhotoSelectViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var photoCategory: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var inputCategoryTag:Int = 0
    
    //let categories: NSArray = ["Accessories", "Shirts", "Pants"]
    
    //parse begin
    var inputCategoryIndex:Int = 0
    
    var inputCategories = [PFObject]()
    var printCategories = [Category]()
    var PFItems: [PFObject]?
    
    
    func add(newItem: Item, toACategory: PFObject) {
        let PFItem = PFObject(className: "Item")
        PFItem["itemId"] = newItem.itemId
        PFItem["itemName"] = newItem.itemName
        PFItem["itemComments"] = newItem.itemComments
        PFItem["belongsToCategory"] = toACategory
        let imageData = UIImageJPEGRepresentation(newItem.itemImage!, 1.0)
      //  let imageData = UIImagePNGRepresentation(newItem.itemImage!)
        let imageFile = PFFile(name: "myfile.png", data:imageData!)
        PFItem["itemImage"] = imageFile
        
        
      //  PFItem["itemImage"] = [PFFile]newItem.itemImage
        //dispatch_sync(dispatch_get_main_queue()) {
        PFItem.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("Saved new Item \(newItem.itemName)")
            } else {
                print("Error in Saving Category: \(error)")
                // There was a problem, check error.description
            }
        }
        //}
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

    
    func addItem(newItem: Item, toACategory: PFObject){
        let PFItem = PFObject(className: "Item")
        PFItem["itemId"] = newItem.itemId
        PFItem["itemName"] = newItem.itemName
        PFItem["itemComments"] = newItem.itemComments
        let imageData = UIImageJPEGRepresentation(newItem.itemImage!, 1.0)
        let imageFile = PFFile(name: "myfile.png", data:imageData!)
        PFItem["itemImage"] = imageFile
        
        var itemData: [AnyObject] = []
        itemData.append(newItem.itemId!)
        itemData.append(imageFile!)
        
        var query = PFQuery(className: "Category")
        query.getObjectInBackgroundWithId(toACategory.objectId!){
            (myCategory: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print (error)
            } else {
                var currentItems: [AnyObject] = []
                if (toACategory["items"] == nil){
                }
                else{
                   // currentItems = itemData
                  currentItems = toACategory["items"] as! [AnyObject]!
                }
                currentItems.append(itemData)
                toACategory["items"] = currentItems
                print ("in addItem")
                print (toACategory)
                print (toACategory["items"])
                toACategory.saveInBackground()

            }
            
        }
        


        
        
    }
    
    
    
    //parse end
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return inputCategories.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return inputCategories[row]["categoryName"] as! String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.photoCategory.text = inputCategories[row]["categoryName"] as! NSString as String
    }
    
    
    @IBAction func onSaveButton(sender: AnyObject) {
        //save category,image via. Parse
        var selectedCategory = inputCategories[inputCategoryIndex]
        //Add New Item to a Category
        let selectedItem  = Item(itemId: 1, itemName: "", itemImage: inputPhotoImage, itemcomments: "")
        addItem(selectedItem, toACategory: selectedCategory)
        
        print ("saved to parse")
        
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CategoryNavigationController") as! UINavigationController
        self.presentViewController(navController, animated: false, completion: nil)
        // self.navigationController?.pushViewController(navController, animated: false)
    }
    
    
    var inputPhotoCategory: String!
    var inputPhotoImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // let accessoriesCategory = Category(categoryName: "Pants")
       // add(accessoriesCategory)
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        
        // Do any additional setup after loading the view.
        photoCategory.text = inputPhotoCategory
        photoImage.image = inputPhotoImage
        pickerView.selectRow(inputCategoryTag, inComponent: 0, animated: false)
        // mPicker.selectRow(defaultRowIndex!, inComponent: 0, animated: false)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
