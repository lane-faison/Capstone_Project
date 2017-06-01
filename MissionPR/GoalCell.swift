//
//  GoalCell.swift
//  MissionPR
//
//  Created by Lane Faison on 5/31/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

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
        print("Configure process function...")
       
        let transform = CGAffineTransform(scaleX: 1.0, y: 8.0)
        self.progressView.transform = transform
        
        let progress = Float(goalLift.current)/Float(goalLift.weight)
        let progressFactor:CGFloat = (CGFloat(progress)*255)/255

        progressView.setProgress(Float(goalLift.current)/Float(goalLift.weight), animated: true)
        progressView.progressTintColor = UIColor(red: 83/255, green: progressFactor, blue: 254/255, alpha: 1.0)
    }

}
