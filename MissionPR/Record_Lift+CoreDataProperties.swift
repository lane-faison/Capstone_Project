//
//  Record_Lift+CoreDataProperties.swift
//  MissionPR
//
//  Created by Lane Faison on 6/18/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import Foundation
import CoreData


extension Record_Lift {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record_Lift> {
        return NSFetchRequest<Record_Lift>(entityName: "Record_Lift")
    }

    @NSManaged public var name: String?
    @NSManaged public var reps: Int16
    @NSManaged public var weight: Int16

}
