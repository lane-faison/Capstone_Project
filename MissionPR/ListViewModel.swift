//
//  ListViewModel.swift
//  MissionPR
//
//  Created by Lane Faison on 12/17/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import Foundation
import CoreData

final class ListViewModel {
    
    private var type: HomeCellType!
    
    init(type: HomeCellType) {
        self.type = type
        
        generateTestDataForLists()
    }
    
    var viewTitle: String {
        return type.title().capitalized
    }
}

extension ListViewModel {
    
    private func generateTestDataForLists() {
        let goal1 = Goal_Lift(context: context)
        goal1.name = "Flat Bench Press"
        goal1.weight = 225
        goal1.reps = 10
        goal1.current = 205
        
        let goal2 = Goal_Lift(context: context)
        goal2.name = "Barbell Shoulder Press"
        goal2.weight = 135
        goal2.reps = 10
        goal2.current = 110
        
        let goal3 = Goal_Lift(context: context)
        goal3.name = "Barbell Squat"
        goal3.weight = 205
        goal3.reps = 10
        goal3.current = 195
        
        let goal4 = Goal_Lift(context: context)
        goal4.name = "Power Cleans"
        goal4.weight = 135
        goal4.reps = 10
        goal4.current = 85
        
        let goal5 = Goal_Lift(context: context)
        goal5.name = "Roman Deadlifts"
        goal5.weight = 265
        goal5.reps = 10
        goal5.current = 205
        
        ad.saveContext()
    }
}
