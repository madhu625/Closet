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
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var inputCategoryTag:Int = 0
    
    //parse begin
    var inputCategoryIndex:Int = 0
    
    var inputCategories = [PFObject]()
    var printCategories = [Category]()
    var PFItems: [PFObject]?

    func add(newCategory: Category) {
        let PFCategory = PFObject(className: "Category")
        PFCategory["categoryName"] = newCategory.categoryName
       // PFCategory["ownedBy"] = PFUser.currentUser()
        
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
        let imageData = UIImageJPEGRepresentation(newItem.itemImage!, 1.0)
        let imageFile = PFFile(name: "myfile.png", data:imageData!)
        var query = PFQuery(className: "Category")
        query.getObjectInBackgroundWithId(toACategory.objectId!){
            (myCategory: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print ("in addItem error")
                print (error)
            } else {
                var currentItems: [AnyObject] = []
                if (toACategory["items"] == nil){
                }
                else {
                  currentItems = toACategory["items"] as! [AnyObject]!
                }
                currentItems.append(imageFile!)
                print ("currentItems after append")

                print (currentItems)
                toACategory["ownedBy"] = PFUser.currentUser()
                toACategory["items"] = currentItems

                toACategory.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                    if error == nil {
                        print ("file saved successfully")
                    } else {
                        print (error)
                        print ("error in saving new item")
                    }
                }
            
            } //end of else for null currentItems
        } //end of getObjectInBackgroundWithId

    } //end of addItem
    
    
    //parse end
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return inputCategories.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return inputCategories[row]["categoryName"] as! String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
       // self.photoCategory.text = inputCategories[row]["categoryName"] as! NSString as String
        self.inputCategoryIndex = row
    }
    
    
    @IBAction func onSaveButton(sender: AnyObject) {
        //save category,image via. Parse
        let selectedCategory = inputCategories[inputCategoryIndex]
       
        //Add New Item to a Category
        let selectedItem  = Item(itemId: 1, itemName: "", itemImage: inputPhotoImage, itemcomments: "")
        addItem(selectedItem, toACategory: selectedCategory)
        
       // print ("saved to parse")
       let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CategoryNavigationController") as! UINavigationController
       self.presentViewController(navController, animated: false, completion: nil)
    }
    
    
    var inputPhotoCategory: String!
    var inputPhotoImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        
        // Do any additional setup after loading the view.
        photoImage.image = inputPhotoImage
        pickerView.selectRow(inputCategoryTag, inComponent: 0, animated: false)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
