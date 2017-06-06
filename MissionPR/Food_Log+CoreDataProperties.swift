//
//  Food_Log+CoreDataProperties.swift
//  MissionPR
//
//  Created by Lane Faison on 6/5/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import Foundation
import CoreData


extension Food_Log {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food_Log> {
        return NSFetchRequest<Food_Log>(entityName: "Food_Log")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: NSDate?

}
