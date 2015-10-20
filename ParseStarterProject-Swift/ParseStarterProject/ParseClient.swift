//
//  ParseClient.swift
//  ParseStarterProject-Swift
//
//  Created by Jay Shah on 10/18/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ParseClient {
    
    var _categories = [[String: AnyObject]]()
    
    var categories:[[String: AnyObject]] {
        get {
            return _categories
        }
        set (newVal){
            _categories = newVal
        }
    }
    
    class var sharedInstance : ParseClient {
        
        struct Static {
            static var token : dispatch_once_t = 0
            static var instance : ParseClient? = nil
        }
        dispatch_once(&Static.token) {
            Static.instance = ParseClient()
        }
        
        
        return Static.instance!
    }
    
    
    
    func fetchAllCategories (completion: ([[String:AnyObject]]!, NSError!) -> Void) {
        
        var categories = [[String: AnyObject]] ()
        
        let query = PFQuery(className: "Category")
        
        query.findObjectsInBackgroundWithBlock { (cat :[PFObject]?, error: NSError?) -> Void in
            if cat != nil {
                
                for category in cat! {
                    
                    let temp = ["name": category["categoryName"], "objectId" : category.objectId!]
                    categories.append(temp)
                    
                }
                completion(categories,nil)
                
            }
            else {
                
                completion(nil,error)
                
            }
            
        }
    }
    
    func fetchItemsByCateogires(categoryName: String, completion: ([Item]!, NSError!) -> Void ) {
        
        var allItems: [Item]?
        
        
        let innerQuery = PFQuery(className: "Category")
        innerQuery.whereKey("categoryName", equalTo: categoryName)
        
        let query = PFQuery(className: "Item")
        query.whereKey("belongsToCategory", matchesQuery: innerQuery)
        
        query.findObjectsInBackgroundWithBlock { (data: [PFObject]?, error: NSError?) -> Void in
            
            if data != nil {
                
                completion(allItems,nil)
                
            } else {
                
                completion(nil, error)
                
            }
            
        }
    }
    
    func fetchRandomOutfit (completion: ([Item]!, NSError!) -> Void) {
        
    }
    
    func fetchOutfits () {
        
    }
    
    //    func fetchCloset (completion: ([Item]!, NSError!) -> Void) {
    //
    //        var categories = [[String: AnyObject]] ()
    //
    //        let query = PFQuery(className: "Category")
    //
    //        query.findObjectsInBackgroundWithBlock { (cat :[PFObject]?, error: NSError?) -> Void in
    //            if cat != nil {
    //
    //                for category in cat! {
    //
    //                    let temp = ["name": category["categoryName"], "objectId" : category.objectId!]
    //                    categories.append(temp)
    //
    //                }
    //                completion(categories,nil)
    //
    //            }
    //            else {
    //
    //                completion(nil,error)
    //
    //            }
    //            
    //        }
    //        
    //    
    //    }
    
    
}
