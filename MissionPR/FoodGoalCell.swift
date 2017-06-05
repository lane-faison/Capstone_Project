//
//  FoodGoalCell.swift
//  MissionPR
//
//  Created by Lane Faison on 6/5/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit

class FoodGoalCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var current: UILabel!
    @IBOutlet weak var goal: UILabel!
    
    func configureCell(goalFood: Goal_Food) {
        view.layer.cornerRadius = 5
        name.text = goalFood.name
        
    }
    
}
