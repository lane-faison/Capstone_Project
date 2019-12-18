//
//  HomeViewModel.swift
//  MissionPR
//
//  Created by Lane Faison on 12/9/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

enum HomeCellType: String {
    case biking
    case rowing
    case running
    case swimming
    case weightlifting
    
    func title() -> String {
        return self.rawValue.capitalized
    }
    
    func iconImage() -> UIImage? {
        switch self {
        case .biking:
            return AppImage.get(.biker)
        case .rowing:
            return AppImage.get(.rower)
        case .running:
            return AppImage.get(.runner)
        case .swimming:
            return AppImage.get(.swimmer)
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
    private let fourthOptionCellViewModel = HomeCellViewModel(type: .rowing)
    private let fifthOptionCellViewModel = HomeCellViewModel(type: .swimming)
    
    var data: [HomeCellConfigurator] {
        return getData()
    }
    
    private func getData() -> [HomeCellConfigurator] {
        let data = [
            HomeCellConfigurator(viewModel: firstOptionCellViewModel),
            HomeCellConfigurator(viewModel: secondOptionCellViewModel),
            HomeCellConfigurator(viewModel: thirdOptionCellViewModel),
            HomeCellConfigurator(viewModel: fourthOptionCellViewModel),
            HomeCellConfigurator(viewModel: fifthOptionCellViewModel)
        ]
        return data
    }
}
