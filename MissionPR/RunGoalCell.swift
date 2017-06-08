//
//  RunGoalCell.swift
//  MissionPR
//
//  Created by Lane Faison on 6/2/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit

class RunGoalCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var units: UILabel!
    @IBOutlet weak var current: UILabel!
    @IBOutlet weak var goal: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    func configureCell(goalRun: Goal_Run) {
        view.layer.cornerRadius = 5
        name.text = goalRun.name
        distance.text = "\(goalRun.distance)"
        units.text = "\(goalRun.units!)"
        current.text = "\(goalRun.currentTime)"
        goal.text = "\(goalRun.goalTime)"
    }
    
    func configureProgress(goalRun: Goal_Run) {
        print("Configure process function...")
        
        let transform = CGAffineTransform(scaleX: 1.0, y: 10.0)
        self.progressView.transform = transform
        
        let progress = Float(goalRun.goalTime)/Float(goalRun.currentTime)
        
        progressView.setProgress(Float(goalRun.goalTime)/Float(goalRun.currentTime), animated: true)
        
        if progress <= 1.00 {
            progressView.progressTintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0)
        }
        if progress <= 0.85 {
            progressView.progressTintColor = UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1.0)
        }
        if progress <= 0.70 {
            progressView.progressTintColor = UIColor(red: 244/255, green: 67/255, blue: 54/255, alpha: 1.0)
        }
        
        
    }

}
