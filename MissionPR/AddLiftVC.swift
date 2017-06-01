//
//  AddLiftVC.swift
//  MissionPR
//
//  Created by Lane Faison on 6/1/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit

class AddLiftVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var repsPicker: UIPickerView!
    @IBOutlet weak var goalPicker: UIPickerView!
    @IBOutlet weak var currentPicker: UIPickerView!
    
    var reps = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    var goal = [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110,115,120,125,130,135,140,145,150,155,160,165,170,175,180,185,190,195,200,205,210,215,220,225,230,235,240,245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320,325,330,335,340,345,350,355,360,365,370,375,380,385,390,395,400,405,410,415,420,425,430,435,440,445,450,455,460,465,470,475,480,485,490,495,500]
    var current = [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110,115,120,125,130,135,140,145,150,155,160,165,170,175,180,185,190,195,200,205,210,215,220,225,230,235,240,245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320,325,330,335,340,345,350,355,360,365,370,375,380,385,390,395,400,405,410,415,420,425,430,435,440,445,450,455,460,465,470,475,480,485,490,495,500]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        repsPicker.delegate = self
        repsPicker.dataSource = self
        goalPicker.delegate = self
        goalPicker.dataSource = self
        currentPicker.delegate = self
        currentPicker.dataSource = self
        
        repsPicker.selectRow(0, inComponent: 0, animated: true)
        goalPicker.selectRow(19, inComponent: 0, animated: true)
        currentPicker.selectRow(19, inComponent: 0, animated: true)

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
    


}
