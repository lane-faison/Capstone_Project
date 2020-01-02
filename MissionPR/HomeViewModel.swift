//
//  HomeViewModel.swift
//  MissionPR
//
//  Created by Lane Faison on 12/9/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit
import RealmSwift

enum HomeCellType: String, CaseIterable {
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
    
    func objectType() -> Object.Type? {
        switch self {
        case .weightlifting:
            return Lift.self
        default:
            return nil
        }
    }
}

protocol HomeViewModelDelegate: class {
    func cellTapped(type: HomeCellType)
}

final class HomeViewModel {
    
    typealias HomeCellConfigurator = TableViewCellConfigurator<HomeTableViewCell, HomeCellViewModel>
    
    weak var delegate: HomeViewModelDelegate?
    
    var data: [HomeCellConfigurator] {
        return getData()
    }
    
    private func getData() -> [HomeCellConfigurator] {
        var data: [HomeCellConfigurator] = []
        
        for type in HomeCellType.allCases {
            let cellViewModel = HomeCellViewModel(type: type) {
                self.delegate?.cellTapped(type: type)
            }
            let configurator = HomeCellConfigurator(viewModel: cellViewModel)
            data.append(configurator)
        }
        
        return data
    }
}
