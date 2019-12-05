//
//  TitleButtonViewModel.swift
//  MissionPR
//
//  Created by Lane Faison on 12/4/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

final class TitleButtonViewModel {
    
    var title: String
    var buttonImage: UIImage
    var buttonTapAction: (() -> Void)
    
    init(title: String, buttonImage: UIImage, buttonTapAction: @escaping (() -> Void)) {
        self.title = title
        self.buttonImage = buttonImage
        self.buttonTapAction = buttonTapAction
    }
}
