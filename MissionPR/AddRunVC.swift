//
//  AddRunVC.swift
//  MissionPR
//
//  Created by Lane Faison on 6/1/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit
import CoreData

class AddRunVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    let limitLength = 22 //character length for above text field
    @IBOutlet weak var distancePicker: UIPickerView!
    @IBOutlet weak var currentPicker: UIPickerView!
    @IBOutlet weak var goalPicker: UIPickerView!
    @IBOutlet weak var saveBtn: RoundedOutlineButton!
    
    var goalToEdit: Goal_Run?
    
    var distanceDataSource = [[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30],["mi","km"]]
    
    var timeDataSource = [[0,1,2,3,4,5],[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59],[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        distancePicker.delegate = self
        distancePicker.dataSource = self
        currentPicker.delegate = self
        currentPicker.dataSource = self
        goalPicker.delegate = self
        goalPicker.dataSource = self
        
        if goalToEdit != nil {
            loadGoalData()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= limitLength
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == distancePicker {
            return 2
        }
        if pickerView == currentPicker {
            return 3
        }
        if pickerView == goalPicker {
            return 3
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == distancePicker {
            return distanceDataSource[component].count
        }
        if pickerView == currentPicker {
            return timeDataSource[component].count
        }
        if pickerView == goalPicker {
            return timeDataSource[component].count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == distancePicker {
            let choice = "\(distanceDataSource[component][row])"
            return choice
        }
        if pickerView == currentPicker {
            if component == 0 {
                let choice = "\(timeDataSource[component][row])h"
                return choice
            }
            if component == 1 {
                let choice = "\(timeDataSource[component][row])m"
                return choice
            }
            if component == 2 {
                let choice = "\(timeDataSource[component][row])s"
                return choice
            }
        }
        if pickerView == goalPicker {
            if component == 0 {
                let choice = "\(timeDataSource[component][row])h"
                return choice
            }
            if component == 1 {
                let choice = "\(timeDataSource[component][row])m"
                return choice
            }
            if component == 2 {
                let choice = "\(timeDataSource[component][row])s"
                return choice
            }
        }
        return " "
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        return
    }
    
    func loadGoalData() {
        if let runGoal = goalToEdit {
            nameTextField.text = runGoal.name
            
//            let indexOfDistance = distanceDataSource[0].index
//                .index(of: Int(runGoal.distance))
//            let indexOfUnits =
//            let indexOfCurrent = current.index(of: Int(liftGoal.current))
//            let indexOfGoal = goal.index(of: Int(liftGoal.weight))
//            repsPicker.selectRow(indexOfReps!, inComponent: 0, animated: true)
//            currentPicker.selectRow(indexOfCurrent!, inComponent: 0, animated: true)
//            goalPicker.selectRow(indexOfGoal!, inComponent: 0, animated: true)
        }
    }
    
}
