//
//  LiftGoalCell.swift
//  MissionPR
//
//  Created by Lane Faison on 5/31/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit

class LiftGoalCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var current: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var reps: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    func configureCell(goalLift: Goal_Lift) {
        view.layer.cornerRadius = 5
        name.text = goalLift.name
        weight.text = "\(goalLift.weight) Lbs."
        reps.text = "\(goalLift.reps)"
        current.text = "\(goalLift.current) Lbs."
    }
    
    func configureProgress(goalLift: Goal_Lift) {
        
        let transform = CGAffineTransform(scaleX: 1.0, y: 10.0)
        self.progressView.transform = transform
        
        let progress = Float(goalLift.current)/Float(goalLift.weight)
        
        progressView.setProgress(Float(goalLift.current)/Float(goalLift.weight), animated: true)
        if progress == 1.00 {
            name.text = "\(goalLift.name!) 🏅"
        }
        if progress <= 1.00 {
            progressView.progressTintColor = UIColor(red: 169/255, green: 253/255, blue: 0/255, alpha: 1.0)
        }
        if progress <= 0.85 {
            progressView.progressTintColor = UIColor(red: 3/255, green: 169/255, blue: 244/255, alpha: 1.0)
        }
        if progress <= 0.70 {
            progressView.progressTintColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
        }
    }
}
