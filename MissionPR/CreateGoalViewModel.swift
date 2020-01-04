//
//  CreateGoalViewModel.swift
//  MissionPR
//
//  Created by Lane Faison on 12/21/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import Foundation

protocol CreateGoalViewDelegate: class {
    func pickerButtonTapped()
}
final class CreateGoalViewModel {
    
    typealias GoalTextFieldCellConfigurator = TableViewCellConfigurator<GoalTextFieldTableViewCell, GoalTextFieldCellViewModel>
    typealias GoalPickerCellConfigurator = TableViewCellConfigurator<GoalPickerTableViewCell, GoalPickerCellViewModel>
    
    weak var delegate: CreateGoalViewDelegate?
    
    private let nameModel = GoalTextFieldCellViewModel(title: "Name", placeholder: "Edit")
    
    var data: [CellConfigurator] {
        return getData()
    }
    
    private func getData() -> [CellConfigurator] {
        let models: [CellConfigurator] = [
            GoalTextFieldCellConfigurator(viewModel: nameModel),
            GoalPickerCellConfigurator(viewModel: GoalPickerCellViewModel(title: "Reps", placeholder: "Edit", type: .reps, buttonAction: {
                self.pickerButtonTapped()
            }))
        ]
        
        return models
    }
    
    private func pickerButtonTapped() {
        delegate?.pickerButtonTapped()
    }
}
