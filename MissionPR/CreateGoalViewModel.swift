//
//  CreateGoalViewModel.swift
//  MissionPR
//
//  Created by Lane Faison on 12/21/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import Foundation

final class CreateGoalViewModel {
    
    typealias GoalTextFieldCellConfigurator = TableViewCellConfigurator<GoalTextFieldTableViewCell, GoalTextFieldCellViewModel>
    
    private let nameModel = GoalTextFieldCellViewModel(title: "Name", placeholder: "Edit")
    
    var data: [CellConfigurator] {
        return getData()
    }
    
    private func getData() -> [GoalTextFieldCellConfigurator] {
        var data: [GoalTextFieldCellConfigurator] = []
        
        data.append(GoalTextFieldCellConfigurator(viewModel: nameModel))
        
        return data
    }
}
