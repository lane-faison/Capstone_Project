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
    
    @IBOutlet weak var step1Label: UILabel!
    @IBOutlet weak var step2Label: UILabel!
    @IBOutlet weak var step3Label: UILabel!
    @IBOutlet weak var step4Label: UILabel!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    let limitLength = 22 //character length for above text field
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var distancePicker: UIPickerView!
    @IBOutlet weak var currentPicker: UIPickerView!
    @IBOutlet weak var goalPicker: UIPickerView!
    @IBOutlet weak var saveBtn: RoundedOutlineButton!
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    
    var goalToEdit: Goal_Run?
    
    var distanceDataSource = [[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30],[0,1]]
    
    var timeDataSource = [[0,1,2,3,4,5],[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59],[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        }
        
        nameTextField.delegate = self
        distancePicker.delegate = self
        distancePicker.dataSource = self
        currentPicker.delegate = self
        currentPicker.dataSource = self
        goalPicker.delegate = self
        goalPicker.dataSource = self
        
        errorLabel.isHidden = true
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        if goalToEdit != nil {
            loadGoalData()
            step1Label.text = "Edit your running goal's name"
            step3Label.text = "Update time:"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
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
            
            var choice = "\(distanceDataSource[component][row])"
            
            if component == 1 && row == 0 {
                choice = "mi"
            }
            
            if component == 1 && row == 1 {
                choice = "km"
            }
            
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
            
            let indexOfDistance = distanceDataSource[0].firstIndex(of: Int(runGoal.distance))
            distancePicker.selectRow(indexOfDistance!, inComponent: 0, animated: true)
            
            if runGoal.units == "mi" {
                distancePicker.selectRow(0, inComponent: 1, animated: true)
            }
            if runGoal.units == "km" {
                distancePicker.selectRow(1, inComponent: 1, animated: true)
            }
            
            let h_current = runGoal.currentTime/3600
            let m_current = (runGoal.currentTime%3600)/60
            let s_current = (runGoal.currentTime%3600)%60
            
            let h_goal = runGoal.goalTime/3600
            let m_goal = (runGoal.goalTime%3600)/60
            let s_goal = (runGoal.goalTime%3600)%60
            
            let indexOfCurrent_h = timeDataSource[0].firstIndex(of: Int(h_current))
            let indexOfCurrent_m = timeDataSource[1].firstIndex(of: Int(m_current))
            let indexOfCurrent_s = timeDataSource[2].firstIndex(of: Int(s_current))
            
            let indexOfGoal_h = timeDataSource[0].firstIndex(of: Int(h_goal))
            let indexOfGoal_m = timeDataSource[1].firstIndex(of: Int(m_goal))
            let indexOfGoal_s = timeDataSource[2].firstIndex(of: Int(s_goal))
            
            currentPicker.selectRow(indexOfCurrent_h!, inComponent: 0, animated: true)
            currentPicker.selectRow(indexOfCurrent_m!, inComponent: 1, animated: true)
            currentPicker.selectRow(indexOfCurrent_s!, inComponent: 2, animated: true)
            
            goalPicker.selectRow(indexOfGoal_h!, inComponent: 0, animated: true)
            goalPicker.selectRow(indexOfGoal_m!, inComponent: 1, animated: true)
            goalPicker.selectRow(indexOfGoal_s!, inComponent: 2, animated: true)
        }
    }
    
    @IBAction func addPressed(_ sender: Any) {
        
        saveBtn.backgroundColor = UIColor(red: 169/255, green: 253/255, blue: 0, alpha: 1.0)

        var goal: Goal_Run!
        
        if goalToEdit != nil {
            goal = goalToEdit
        }
        
        let distance = self.distanceDataSource[0][self.distancePicker.selectedRow(inComponent: 0)]
        let units = self.distanceDataSource[1][self.distancePicker.selectedRow(inComponent: 1)]
        
        let current_h = self.timeDataSource[0][self.currentPicker.selectedRow(inComponent: 0)]
        let current_m = self.timeDataSource[1][self.currentPicker.selectedRow(inComponent: 1)]
        let current_s = self.timeDataSource[2][self.currentPicker.selectedRow(inComponent: 2)]
        
        let goal_h = self.timeDataSource[0][self.goalPicker.selectedRow(inComponent: 0)]
        let goal_m = self.timeDataSource[1][self.goalPicker.selectedRow(inComponent: 1)]
        let goal_s = self.timeDataSource[2][self.goalPicker.selectedRow(inComponent: 2)]
        
        let currentTimeInSeconds = (current_h * 3600) + (current_m * 60) + current_s
        let goalTimeInSeconds = (goal_h * 3600) + (goal_m * 60) + goal_s
        
        if nameTextField.text != "" {
            
            errorLabel.isHidden = true
            
            if currentTimeInSeconds <= goalTimeInSeconds {
                // Create new run record
                var newRecord: Record_Run!
                
                newRecord = Record_Run(context: context)
                
                newRecord.name = nameTextField.text
                newRecord.time = Int16(currentTimeInSeconds)
                newRecord.date = Date() as NSDate
                newRecord.distance = Int16(distance)
                
                if units == 0 {
                    newRecord.units = "mi"
                }
                if units == 1 {
                    newRecord.units = "km"
                }
                ad.saveContext()
            }

            if goalToEdit == nil {
                goal = Goal_Run(context: context)
                
                if let name = nameTextField.text {
                    goal.name = name
                }
                
                goal.distance = Int16(distance)
                
                if units == 0 {
                    goal.units = "mi"
                }
                if units == 1 {
                    goal.units = "km"
                }
                
                goal.currentTime = Int16(currentTimeInSeconds)
                goal.goalTime = Int16(goalTimeInSeconds)
                ad.saveContext()
                navigationController?.popViewController(animated: true)
            } else {
                if let name = nameTextField.text {
                    goal.name = name
                }
                
                goal.distance = Int16(distance)
                
                if units == 0 {
                    goal.units = "mi"
                }
                if units == 1 {
                    goal.units = "km"
                }
                
                goal.currentTime = Int16(currentTimeInSeconds)
                goal.goalTime = Int16(goalTimeInSeconds)
                ad.saveContext()
                navigationController?.popViewController(animated: true)
            }
        } else {
            errorLabel.text = "* Please give this goal a name"
            errorLabel.isHidden = false
        }
    }
    
    @IBAction func btnTouchDown(_ sender: UIButton) {
        
        if sender == saveBtn {
            saveBtn.backgroundColor = UIColor(red: 3/255, green: 169/255, blue: 244/255, alpha: 1.0)
        }
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        if goalToEdit != nil {
            context.delete(goalToEdit!)
            ad.saveContext()
        }
        navigationController?.popViewController(animated: true)
    }
    
}

extension AddRunVC {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddRunVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
