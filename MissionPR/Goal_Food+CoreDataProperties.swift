//
//  Goal_Food+CoreDataProperties.swift
//  MissionPR
//
//  Created by Lane Faison on 6/5/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import Foundation
import CoreData


extension Goal_Food {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal_Food> {
        return NSFetchRequest<Goal_Food>(entityName: "Goal_Food")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var count: Int16

}
