//
//  Gym_Visits+CoreDataProperties.swift
//  MissionPR
//
//  Created by Lane Faison on 6/4/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import Foundation
import CoreData


extension Gym_Visits {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Gym_Visits> {
        return NSFetchRequest<Gym_Visits>(entityName: "Gym_Visits")
    }
    
    @NSManaged public var date: NSDate
    @NSManaged public var count: Int16

}
