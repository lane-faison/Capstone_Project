//
//  Goal_Run+CoreDataProperties.swift
//  MissionPR
//
//  Created by Lane Faison on 6/8/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import Foundation
import CoreData


extension Goal_Run {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal_Run> {
        return NSFetchRequest<Goal_Run>(entityName: "Goal_Run")
    }

    @NSManaged public var currentTime: Int16
    @NSManaged public var goalTime: Int16
    @NSManaged public var name: String?
    @NSManaged public var distance: Int16
    @NSManaged public var units: String?

}
