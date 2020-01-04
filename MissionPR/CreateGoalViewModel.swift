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
    typealias GoalPickerCellConfigurator = TableViewCellConfigurator<GoalPickerTableViewCell, GoalPickerCellViewModel>
    
    private let nameModel = GoalTextFieldCellViewModel(title: "Name", placeholder: "Edit")
    private let repModel = GoalPickerCellViewModel(title: "Reps", placeholder: "Edit", type: .reps) {
        print("Tap")
    }
    
    var data: [CellConfigurator] {
        return getData()
    }
    
    private func getData() -> [CellConfigurator] {
        var data: [CellConfigurator] = []
        
        data.append(GoalTextFieldCellConfigurator(viewModel: nameModel))
        data.append(GoalPickerCellConfigurator(viewModel: repModel))
        
        return data
    }
}
