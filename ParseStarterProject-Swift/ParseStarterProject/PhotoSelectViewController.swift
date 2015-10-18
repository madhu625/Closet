//
//  PhotoSelectViewController.swift
//  CollectionTableApp
//
//  Created by Deepti Chinta on 10/13/15.
//  Copyright © 2015 DeeptiChinta. All rights reserved.
//

import UIKit

class PhotoSelectViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var photoCategory: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    var inputCategoryTag:Int = 0
    
    let categories: NSArray = ["Shirts", "Pants", "Accessories"]
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return categories[row] as! String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.photoCategory.text = categories[row] as! NSString as String
    }
    
    
    @IBAction func onSaveButton(sender: AnyObject) {
        //save category,image via. Parse
        print ("saved to parse")
        
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CategoryNavigationController") as! UINavigationController
        self.presentViewController(navController, animated: false, completion: nil)
        // self.navigationController?.pushViewController(navController, animated: false)
    }
    
    
    var inputPhotoCategory: String!
    var inputPhotoImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
