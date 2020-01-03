//
//  GoalPickerTableViewCell.swift
//  MissionPR
//
//  Created by Lane Faison on 1/2/20.
//  Copyright © 2020 Lane Faison. All rights reserved.
//

import UIKit

class GoalPickerTableViewCell: UITableViewCell, ConfigurableCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: GoalPickerCellViewModel) {
        
    }
}
