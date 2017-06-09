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
        
        let h_current = goalRun.currentTime/3600
        let m_current = (goalRun.currentTime%3600)/60
        let s_current = (goalRun.currentTime%3600)%60
        
        let h_goal = goalRun.goalTime/3600
        let m_goal = (goalRun.goalTime%3600)/60
        let s_goal = (goalRun.goalTime%3600)%60
        
        if h_current > 0 {
            current.text = "\(h_current):\(m_current):\(s_current)"
        } else {
            current.text = "\(m_current):\(s_current)"
        }
        
        if h_goal > 0 {
            goal.text = "\(h_goal):\(m_goal):\(s_goal)"
        } else {
            goal.text = "\(m_goal):\(s_goal)"
        }
        
        view.layer.cornerRadius = 5
        name.text = goalRun.name
        distance.text = "\(goalRun.distance)"
        units.text = "\(goalRun.units!)"
    }
    
    func configureProgress(goalRun: Goal_Run) {
        print("Configure process function...")
        secondsToHoursMinutesSeconds(seconds: goalRun.currentTime)
        let transform = CGAffineTransform(scaleX: 1.0, y: 10.0)
        self.progressView.transform = transform
        
        let progress = Float(goalRun.goalTime)/Float(goalRun.currentTime)
        
        var progressRatio: Float!
        
        if progress >= 1.00 {
            progressRatio = 1.00
            name.text = "\(goalRun.name!) (Achieved!)"
        } else {
            progressRatio = progress
        }
        
        progressView.setProgress(progressRatio, animated: true)
        
        if progressRatio > 0.85 {
            progressView.progressTintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0)
        }
        if progressRatio <= 0.85 {
            progressView.progressTintColor = UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1.0)
        }
        if progressRatio <= 0.70 {
            progressView.progressTintColor = UIColor(red: 244/255, green: 67/255, blue: 54/255, alpha: 1.0)
        }
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int16) -> (Int16,Int16,Int16) {
        let h = seconds/3600
        let m = (seconds%3600)/60
        let s = (seconds%3600)%60
        print("@@@@@ \(h), \(m), \(s)")
        return (h,m,s)
    }

}
