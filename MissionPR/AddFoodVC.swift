//
//  AddFoodVC.swift
//  MissionPR
//
//  Created by Lane Faison on 6/5/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit
import CoreData

class AddFoodVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate {

    
    @IBOutlet weak var foodPicker: UIPickerView!
    @IBOutlet weak var trackBtn: RoundedOutlineButton!
    
    var foods = ["Fruits","Vegetables"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        foodPicker.delegate = self
        foodPicker.dataSource = self
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return foods[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return foods.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // update when selected
    }
    

    @IBAction func trackBtnPressed(_ sender: Any) {
        var food: Goal_Food!
        food = Goal_Food(context: context)
        let name = self.foods[foodPicker.selectedRow(inComponent: 0)]
        
        if name == "Fruits" {
            food.name = "fruit"
        }
        if name == "Vegetables" {
            food.name = "vegetable"
        }
        food.date = Date() as NSDate
        
        ad.saveContext()
        navigationController?.popViewController(animated: true)
    }


}
