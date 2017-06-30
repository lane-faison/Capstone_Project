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
    
    func configureCell(recordRun: Record_Run) {
        
        view.layer.cornerRadius = 5.0
        
        let recordDateFormatter = DateFormatter()
        recordDateFormatter.dateFormat = "MMMM dd, yyyy"
        recordDate = recordDateFormatter.string(from: recordRun.date! as Date)
        
        let h_record = recordRun.time/3600
        let m_record = recordRun.time%3600/60
        let s_record = (recordRun.time%3600)%60
        
        if h_record > 0 {
            timeLabel.text = "\(h_record):\(m_record):\(s_record)"
            
            if m_record < 10 {
                timeLabel.text = "\(h_record):0\(m_record):\(s_record)"
            }
            
            if s_record < 10 {
                timeLabel.text = "\(h_record):\(m_record):0\(s_record)"
            }
            
            if m_record < 10 && s_record < 10 {
                timeLabel.text = "\(h_record):0\(m_record):0\(s_record)"
            }
        } else {
            timeLabel.text = "\(m_record):\(s_record)"
            
            if m_record < 10 {
                timeLabel.text = "\(m_record):\(s_record)"
            }
            
            if s_record < 10 {
                timeLabel.text = "\(m_record):0\(s_record)"
            }
            
            if m_record < 10 && s_record < 10 {
                timeLabel.text = "\(m_record):0\(s_record)"
            }
        }
        
        nameLabel.text = recordRun.name
        distanceLabel.text = "\(recordRun.distance)"
        unitsLabel.text = "\(recordRun.units!)"
        timeStampLabel.text = recordDate
    }
}
