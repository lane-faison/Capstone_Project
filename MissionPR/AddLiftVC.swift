//
//  AddLiftVC.swift
//  MissionPR
//
//  Created by Lane Faison on 6/1/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit
import CoreData

class AddLiftVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate {

    @IBOutlet weak var step1Label: UILabel!
    @IBOutlet weak var step2Label: UILabel!
    @IBOutlet weak var step3Label: UILabel!
    @IBOutlet weak var step4Label: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    let limitLength = 22 //character length for above text field
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var repsPicker: UIPickerView!
    @IBOutlet weak var goalPicker: UIPickerView!
    @IBOutlet weak var currentPicker: UIPickerView!
    @IBOutlet weak var submitBtn: RoundedOutlineButton!
    @IBOutlet weak var deleteBtn: UIBarButtonItem!

    var goalToEdit: Goal_Lift?
    
    var reps = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    var goal = [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110,115,120,125,130,135,140,145,150,155,160,165,170,175,180,185,190,195,200,205,210,215,220,225,230,235,240,245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320,325,330,335,340,345,350,355,360,365,370,375,380,385,390,395,400,405,410,415,420,425,430,435,440,445,450,455,460,465,470,475,480,485,490,495,500]
    var current = [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110,115,120,125,130,135,140,145,150,155,160,165,170,175,180,185,190,195,200,205,210,215,220,225,230,235,240,245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320,325,330,335,340,345,350,355,360,365,370,375,380,385,390,395,400,405,410,415,420,425,430,435,440,445,450,455,460,465,470,475,480,485,490,495,500]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        nameTextField.delegate = self
        repsPicker.delegate = self
        repsPicker.dataSource = self
        goalPicker.delegate = self
        goalPicker.dataSource = self
        currentPicker.delegate = self
        currentPicker.dataSource = self
        
        errorLabel.isHidden = true
        
        repsPicker.selectRow(0, inComponent: 0, animated: true)
        goalPicker.selectRow(19, inComponent: 0, animated: true)
        currentPicker.selectRow(19, inComponent: 0, animated: true)
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        if goalToEdit != nil {
            loadGoalData()
            step1Label.text = "Edit your lifting goal's name"
            step2Label.text = "Edit number of reps"
            step3Label.text = "Update current max"
            step4Label.text = "Edit goal max"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= limitLength
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == repsPicker {
            let choice = "\(reps[row])"
            return choice
        }
        if pickerView == goalPicker {
            let choice = "\(goal[row])"
            return choice
        }
        if pickerView == currentPicker {
            let choice = "\(current[row])"
            return choice
        }
        return "nil"
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == repsPicker {
            return reps.count
        }
        if pickerView == goalPicker {
            return goal.count
        }
        if pickerView == currentPicker {
            return current.count
        }
        return 1
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //update when selected
    }
    
    @IBAction func addPressed(_ sender: Any) {
        var goal: Goal_Lift!
        
        if goalToEdit != nil {
            goal = goalToEdit
        }

        let reps = self.reps[repsPicker.selectedRow(inComponent: 0)]
        let goalWeight = self.goal[goalPicker.selectedRow(inComponent: 0)]
        let currentWeight = self.current[currentPicker.selectedRow(inComponent: 0)]
        
        if (currentWeight <= goalWeight && nameTextField.text != "") {
            errorLabel.isHidden = true
            
            if goalToEdit == nil {
                goal = Goal_Lift(context: context)
                
                if let name = nameTextField.text {
                    goal.name = name
                }
                
                goal.reps = Int16(reps)
                goal.weight = Int16(goalWeight)
                goal.current = Int16(currentWeight)
                ad.saveContext()
                navigationController?.popViewController(animated: true)
            } else {
                
                if let name = nameTextField.text {
                    goal.name = name
                }
                
                goal.reps = Int16(reps)
                goal.weight = Int16(goalWeight)
                goal.current = Int16(currentWeight)
                ad.saveContext()
                navigationController?.popViewController(animated: true)
            }
        }
        else if currentWeight > goalWeight {
            errorLabel.isHidden = false
            errorLabel.text = "* Current max must be less than goal max"
        }
        else if nameTextField.text == "" {
            errorLabel.isHidden = false
            errorLabel.text = "* Please give this goal a name"
        }
        else {
            //
        }
    }
    
    func loadGoalData() {
        if let liftGoal = goalToEdit {
            nameTextField.text = liftGoal.name

            let indexOfReps = reps.index(of: Int(liftGoal.reps))
            let indexOfCurrent = current.index(of: Int(liftGoal.current))
            let indexOfGoal = goal.index(of: Int(liftGoal.weight))
            repsPicker.selectRow(indexOfReps!, inComponent: 0, animated: true)
            currentPicker.selectRow(indexOfCurrent!, inComponent: 0, animated: true)
            goalPicker.selectRow(indexOfGoal!, inComponent: 0, animated: true)
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

extension AddLiftVC {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddLiftVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
