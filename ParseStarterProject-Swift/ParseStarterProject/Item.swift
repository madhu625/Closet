//
//  Item.swift
//  ParseStarterProject-Swift
//
//  Created by Ravinder Matte on 10/10/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class Item: NSObject  {
    
    var itemId: Int?
    var itemName: String?
    //var itemImage: UIImage?
    var itemComments: String?
    
    init(itemId: Int, itemName: String,  itemcomments: String){
        super.init()
        self.itemId = itemId
        self.itemName = itemName
        //self.itemImage = image
        self.itemComments = itemcomments
    }
    
}
