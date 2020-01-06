//
//  CreateGoalViewModel.swift
//  MissionPR
//
//  Created by Lane Faison on 12/21/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import Foundation

protocol CreateGoalViewDelegate: class {
    func pickerButtonTapped(type: PickerType)
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
                self.pickerButtonTapped(type: .reps)
            })),
            GoalPickerCellConfigurator(viewModel: GoalPickerCellViewModel(title: "Current Weight", placeholder: "Edit", type: .weight, buttonAction: {
                self.pickerButtonTapped(type: .weight)
            })),
            GoalPickerCellConfigurator(viewModel: GoalPickerCellViewModel(title: "Goal Weight", placeholder: "Edit", type: .weight, shouldHideDivider: true, buttonAction: {
                self.pickerButtonTapped(type: .weight)
            }))
        ]
        
        return models
    }
    
    private func pickerButtonTapped(type: PickerType) {
        delegate?.pickerButtonTapped(type: type)
    }
    
    func getNumberOfPickerComponents() -> Int {
        return 1
    }
    
    func getNumberOfRowsInPickerComponent() -> Int {
        return 2
    }
}
