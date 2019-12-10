//
//  ConfigurableCell.swift
//  MissionPR
//
//  Created by Lane Faison on 12/9/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

protocol ConfigurableCell {
    associatedtype CellViewModelType
    func configure(viewModel: CellViewModelType)
}

protocol CellConfigurator {
    static var reuseId: String { get }
    func configure(cell: UIView)
    func register(in tableView: UITableView)
}

class TableViewCellConfigurator<CellType: ConfigurableCell, CellViewModelType>: CellConfigurator where CellType.CellViewModelType == CellViewModelType, CellType: UITableViewCell {
    static var reuseId: String { return CellType.reuseIdentifier }
    
    let viewModel: CellViewModelType
    
    init(viewModel: CellViewModelType) {
        self.viewModel = viewModel
    }
    func configure(cell: UIView) {
        (cell as! CellType).configure(viewModel: viewModel)
    }
    
    func register(in tableView: UITableView) {
        tableView.register(CellType.self, forCellReuseIdentifier: CellType.reuseIdentifier)
    }
}
