//
//  CreateGoalViewModel.swift
//  MissionPR
//
//  Created by Lane Faison on 12/21/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import Foundation

final class CreateGoalViewModel {
    
    typealias GoalOptionCellConfigurator = TableViewCellConfigurator<GoalOptionTableViewCell, GoalOptionCellViewModel>
    
    private let nameModel = GoalOptionCellViewModel()
    
    var data: [GoalOptionCellConfigurator] {
        return getData()
    }
    
    private func getData() -> [GoalOptionCellConfigurator] {
        var data: [GoalOptionCellConfigurator] = []
        
        data.append(GoalOptionCellConfigurator(viewModel: nameModel))
        
        return data
    }
}
