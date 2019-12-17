//
//  AppImage.swift
//  MissionPR
//
//  Created by Lane Faison on 12/16/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

enum AppImage: String {
    case arrowLeft = "arrow-left"
    case arrowRight = "arrow-right"
    case biker
    case check
    case close
    case runner
    case weight
    
    static func get(_ type: AppImage) -> UIImage? {
        return UIImage(named: type.rawValue)
    }
}
