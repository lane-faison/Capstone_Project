//
//  HomeViewModel.swift
//  MissionPR
//
//  Created by Lane Faison on 12/9/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import Foundation

final class HomeViewModel {
    
    typealias HomeCellConfigurator = TableViewCellConfigurator<HomeTableViewCell, HomeCellViewModel>
    
    private let firstOptionCellViewModel = HomeCellViewModel(title: "Weightlifting", image: nil)
    private let secondOptionCellViewModel = HomeCellViewModel(title: "Running", image: nil)
    private let thirdOptionCellViewModel = HomeCellViewModel(title: "Diet", image: nil)
    
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
