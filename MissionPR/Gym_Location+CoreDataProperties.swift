//
//  Gym_Location+CoreDataProperties.swift
//  MissionPR
//
//  Created by Lane Faison on 5/31/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import Foundation
import CoreData


extension Gym_Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Gym_Location> {
        return NSFetchRequest<Gym_Location>(entityName: "Gym_Location")
    }

    @NSManaged public var name: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}
