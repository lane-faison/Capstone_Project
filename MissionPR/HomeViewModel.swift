//
//  HomeViewModel.swift
//  MissionPR
//
//  Created by Lane Faison on 12/9/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

enum HomeCellType {
    case biking
    case running
    case weightlifting
    
    func title() -> String {
        switch self {
        case .biking:
            return "Biking"
        case .running:
            return "Running"
        case .weightlifting:
            return "Weightlifting"
        }
    }
    
    func iconImage() -> UIImage? {
        switch self {
        case .biking:
            return AppImage.get(.biker)
        case .running:
            return AppImage.get(.runner)
        case .weightlifting:
            return AppImage.get(.weight)
        }
    }
    
}

final class HomeViewModel {
    
    typealias HomeCellConfigurator = TableViewCellConfigurator<HomeTableViewCell, HomeCellViewModel>
    
    private let firstOptionCellViewModel = HomeCellViewModel(type: .weightlifting)
    private let secondOptionCellViewModel = HomeCellViewModel(type: .running)
    private let thirdOptionCellViewModel = HomeCellViewModel(type: .biking)
    
    var data: [HomeCellConfigurator] {
        return getData()
    }
    
    private func getData() -> [HomeCellConfigurator] {
        let data = [
            HomeCellConfigurator(viewModel: firstOptionCellViewModel),
            HomeCellConfigurator(viewModel: secondOptionCellViewModel),
            HomeCellConfigurator(viewModel: thirdOptionCellViewModel)
        ]
        return data
    }
}
