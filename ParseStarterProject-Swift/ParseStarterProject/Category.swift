//
//  shelf.swift
//  ParseStarterProject-Swift
//
//  Created by Ravinder Matte on 10/10/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class Category: NSObject {
    var categoryName: String? // Example: Top, Shoes, Appeareal
    
    init(categoryName: String) {
        super.init()
        self.categoryName = categoryName
    }
    
}



