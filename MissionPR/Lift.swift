//
//  Lift.swift
//  MissionPR
//
//  Created by Lane Faison on 12/21/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import RealmSwift

final class Lift: Object {
    var name: String = ""
    var reps: Int = 0
    var goalWeight: Int = 0
    var currentWeight: Int = 0
    var type = LiftType.barbell.rawValue
    var typeEnum: LiftType {
        get {
            return LiftType(rawValue: type)!
        }
        set {
            type = newValue.rawValue
        }
    }
}

enum LiftType: String {
    case barbell
    case dumbbells
    case machine
}
