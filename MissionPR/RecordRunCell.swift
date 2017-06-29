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
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var units: UILabel!
    @IBOutlet weak var time: UILabel!
    
    var recordRun: Record_Run!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(recordRun: Record_Run) {
        
        
        
        
        
        
        
        
        
        
    }
    
}
