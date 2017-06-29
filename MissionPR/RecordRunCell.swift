//
//  RecordRunCell.swift
//  MissionPR
//
//  Created by Lane Faison on 6/28/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit

class RecordRunCell: UITableViewCell {

    var recordDate = String()
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var recordRun: Record_Run!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(recordRun: Record_Run) {
        
        view.layer.cornerRadius = 5.0
        
        nameLabel.text = recordRun.name
        distanceLabel.text = "\(recordRun.distance)"
        unitsLabel.text = "\(recordRun.units!)"
        timeStampLabel.text = "DATE"
        timeLabel.text = "TIME"
        
        
        
        
        
        
        
    }
    
}
