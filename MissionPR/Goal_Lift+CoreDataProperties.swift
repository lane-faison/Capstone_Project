//
//  Goal_Lift+CoreDataProperties.swift
//  MissionPR
//
//  Created by Lane Faison on 6/1/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import Foundation
import CoreData


extension Goal_Lift {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal_Lift> {
        return NSFetchRequest<Goal_Lift>(entityName: "Goal_Lift")
    }

    @NSManaged public var name: String?
    @NSManaged public var reps: Int16
    @NSManaged public var weight: Int16
    @NSManaged public var current: Int16

}
