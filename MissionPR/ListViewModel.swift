//
//  ListViewModel.swift
//  MissionPR
//
//  Created by Lane Faison on 12/17/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import Foundation

final class ListViewModel {
    
    private var type: HomeCellType!
    
    init(type: HomeCellType) {
        self.type = type
    }
    
    var viewTitle: String {
        return type.title().capitalized
    }
}
