//
//  GoalPickerCellViewModel.swift
//  MissionPR
//
//  Created by Lane Faison on 1/2/20.
//  Copyright © 2020 Lane Faison. All rights reserved.
//

import Foundation

enum PickerType {
    case reps
    case time
    case weight
}

final class GoalPickerCellViewModel {
    
    var title: String
    
    var placeholder: String
    
    var type: PickerType
    
    init(title: String, placeholder: String, type: PickerType) {
        self.title = title
        self.placeholder = placeholder
        self.type = type
    }
}
