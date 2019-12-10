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
    
    init(title: String, image: UIImage?) {
        self.title = title
        self.image = image
    }
}
