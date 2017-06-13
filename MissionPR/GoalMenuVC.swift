//
//  GoalMenuVC.swift
//  MissionPR
//
//  Created by Lane Faison on 6/2/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit

class GoalMenuVC: UIViewController {
    
    @IBOutlet weak var viewLiftGoalsBtn: RoundedOutlineButton!
    @IBOutlet weak var viewRunGoalsBtn: RoundedOutlineButton!
    @IBOutlet weak var viewFoodGoalsBtn: RoundedOutlineButton!
    @IBOutlet weak var viewVisitGoalBtn: RoundedOutlineButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
    }
    
    @IBAction func btnTouchDown(_ sender: UIButton) {
        
        if sender == viewLiftGoalsBtn {
            viewLiftGoalsBtn.backgroundColor = UIColor(red: 3/255, green: 169/255, blue: 244/255, alpha: 1.0)
        }
        if sender == viewRunGoalsBtn {
            viewRunGoalsBtn.backgroundColor = UIColor(red: 3/255, green: 169/255, blue: 244/255, alpha: 1.0)
        }
        if sender == viewFoodGoalsBtn {
            viewFoodGoalsBtn.backgroundColor = UIColor(red: 3/255, green: 169/255, blue: 244/255, alpha: 1.0)
        }
        if sender == viewVisitGoalBtn {
            viewVisitGoalBtn.backgroundColor = UIColor(red: 3/255, green: 169/255, blue: 244/255, alpha: 1.0)
        }
        
    }
    
    @IBAction func btn1TouchUpInside(_ sender: UIButton) {
        viewLiftGoalsBtn.backgroundColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0)
    }
    @IBAction func btn2TouchUpInside(_ sender: UIButton) {
        viewRunGoalsBtn.backgroundColor = UIColor(red: 114/255, green: 201/255, blue: 0, alpha: 1.0)
    }
    @IBAction func btn3TouchUpInside(_ sender: UIButton) {
        viewFoodGoalsBtn.backgroundColor = UIColor(red: 169/255, green: 253/255, blue: 0, alpha: 1.0)
    }
    @IBAction func btn4TouchUpInside(_ sender: UIButton) {
        viewVisitGoalBtn.backgroundColor = UIColor(red: 224/255, green: 255/255, blue: 87/255, alpha: 1.0)
    }
}
