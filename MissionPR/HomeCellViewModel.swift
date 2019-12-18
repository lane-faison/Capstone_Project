//
//  HomeCellViewModel.swift
//  MissionPR
//
//  Created by Lane Faison on 12/9/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

final class HomeCellViewModel {
    
    var title: String
    var image: UIImage?
    var tapAction: (() -> Void)?
    
    init(type: HomeCellType, tapAction: (() -> Void)?) {
        self.title = type.title()
        self.image = type.iconImage()
        self.tapAction = tapAction
    }
}
