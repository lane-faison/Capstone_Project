//
//  Record_Run+CoreDataProperties.swift
//  MissionPR
//
//  Created by Lane Faison on 6/28/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import Foundation
import CoreData


extension Record_Run {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record_Run> {
        return NSFetchRequest<Record_Run>(entityName: "Record_Run")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var distance: Int16
    @NSManaged public var units: String?
    @NSManaged public var time: Int16

}
