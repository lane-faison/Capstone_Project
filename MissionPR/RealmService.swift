//
//  RealmService.swift
//  MissionPR
//
//  Created by Lane Faison on 12/20/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import RealmSwift

final class RealmService {
    
    static func createObject(_ object: Object) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(object)
        }
    }
    
    static func createLift(_ lift: Lift) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(lift)
        }
    }
    
    static func fetchObjects(_ object: Object.Type, completion: (([Object]) -> Void)?) {
        let realm = try! Realm()
        let objects = realm.objects(object.self)
        let objectsArray = Array(objects)
        
        completion?(objectsArray)
    }
}
