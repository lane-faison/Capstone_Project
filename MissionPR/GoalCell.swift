//
//  GoalCell.swift
//  MissionPR
//
//  Created by Lane Faison on 5/31/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var reps: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    func configureCell(goalLift: Goal_Lift) {
        name.text = goalLift.name
        weight.text = "\(goalLift.weight) Lbs."
        reps.text = "\(goalLift.reps)"
        progressView.setProgress(0.5, animated: true)
        progressView.progressTintColor = UIColor.blue
    }

}
