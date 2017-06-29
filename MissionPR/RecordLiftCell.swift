//
//  RecordLiftCell.swift
//  MissionPR
//
//  Created by Lane Faison on 6/18/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit

class RecordLiftCell: UITableViewCell {
    
    var recordDate = String()
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    var recordLift: Record_Lift!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(recordLift: Record_Lift) {
        
        view.layer.cornerRadius = 5
        
        let recordDateFormatter = DateFormatter()
        recordDateFormatter.dateFormat = "MMMM dd, yyyy"
        recordDate = recordDateFormatter.string(from: recordLift.timeStamp! as Date)
        
        dateLabel.text = recordDate
        nameLabel.text = recordLift.name?.capitalized
        repsLabel.text = "\(recordLift.reps) reps"
        weightLabel.text = "\(recordLift.weight) Lbs."
    }
    
}
