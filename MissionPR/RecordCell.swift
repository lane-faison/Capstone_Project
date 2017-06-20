//
//  RecordCell.swift
//  MissionPR
//
//  Created by Lane Faison on 6/18/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit

class RecordCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    var recordLift: Record_Lift!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ recordLift: Record_Lift) {
        self.recordLift = recordLift
        thumbImg.image = UIImage(named: "target-black")
        nameLabel.text = self.recordLift.name?.capitalized
        repsLabel.text = "\(self.recordLift.reps)"
        weightLabel.text = "\(self.recordLift.weight)"
    }
    
}