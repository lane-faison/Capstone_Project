//
//  Goal_Visits+CoreDataProperties.swift
//  MissionPR
//
//  Created by Lane Faison on 6/1/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import Foundation
import CoreData


extension Goal_Visits {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal_Visits> {
        return NSFetchRequest<Goal_Visits>(entityName: "Goal_Visits")
    }

    @NSManaged public var name: String?
    @NSManaged public var frequency: Int16

}
