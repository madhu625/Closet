//
//  CategoryViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Ravinder Matte on 10/11/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class CategoryViewController: UIViewController {

    var categories = [PFObject]()
    var printCategories = [Category]()
    var PFItems: [PFObject]?

    override func viewDidLoad() {
        super.viewDidLoad()
        //Intial Load - Test Data
        //self.categories = getAllItems()


        // Add New Category
        // let topCategory = Category(categoryName: "Top")
        // add(topCategory)
        
        let topCategory = PFObject(className: "Category")
        topCategory["categoryName"] = "Top"
        topCategory["ownedBy"] = PFUser.currentUser()

        let bottomCategory = PFObject(className: "Category")
        bottomCategory["categoryName"] = "Bottom"
        bottomCategory["ownedBy"] = PFUser.currentUser()

        let shoesCategory = PFObject(className: "Category")
        shoesCategory["categoryName"] = "Shoes"
        shoesCategory["ownedBy"] = PFUser.currentUser()

        
        //Add New Item to a Category
        let top1 = Item(itemId: 1, itemName: "Top1", itemcomments: "Top1")
        add(top1, toACategory: topCategory)

        // Adding some more Items.
        let top2 = Item(itemId: 2, itemName: "Top1", itemcomments: "Top2")
        let top3 = Item(itemId: 3, itemName: "Top3", itemcomments: "Top3")
        let top4 = Item(itemId: 4, itemName: "Top4", itemcomments: "Top4")
        let bottom1 = Item(itemId: 1, itemName: "Bottom1", itemcomments: "Bottom1")
        let bottom2 = Item(itemId: 2, itemName: "Bottom2", itemcomments: "Bottom2")

        add(top2, toACategory: topCategory)
        add(top3, toACategory: topCategory)
        add(top4, toACategory: topCategory)
        
        add(bottom1, toACategory: bottomCategory)
        add(bottom2, toACategory: bottomCategory)

        self.categories = [topCategory, bottomCategory]
        
        itemsFrom(topCategory)
//        for item in topItems {
//            print(item["itemName"])
//        }
    }
    
    func itemsFrom(category: PFObject) -> () {
        
        let query = PFQuery(className:"Item")
        //query.whereKey("belongsToCategory", equalTo:category)
        //dispatch_sync(dispatch_get_main_queue()) {
            query.findObjectsInBackgroundWithBlock {
                (items: [PFObject]?, error: NSError?) -> Void in
            
                    if error == nil {
                        // The find succeeded.
                        print("Successfully retrieved \(items!.count).")
                        // Do something with the found objects
                        if let items = items as [PFObject]? {
                            self.PFItems = items
                        }
                        for pfitem in self.PFItems! {
                            print(pfitem["itemName"])
                        }
                    } else {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
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

    
    func add(newItem: Item, toACategory: PFObject) {
        let PFItem = PFObject(className: "Item")
        PFItem["itemId"] = newItem.itemId
        PFItem["itemName"] = newItem.itemName
        PFItem["itemComments"] = newItem.itemComments
        PFItem["belongsToCategory"] = toACategory
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

    @IBAction func SaveItems(sender: UIButton) {
        //performSegueWithIdentifier("ParseLogin", sender: self)
        //saveItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        
    }

}
