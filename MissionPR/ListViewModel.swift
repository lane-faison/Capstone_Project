//
//  ListViewModel.swift
//  MissionPR
//
//  Created by Lane Faison on 12/17/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import Foundation
import RealmSwift

protocol ListViewDelegate: class {
    func needsReload()
}

final class ListViewModel {
    
    typealias ListCellConfigurator = TableViewCellConfigurator<ListTableViewCell, ListCellViewModel>
    
    weak var delegate: ListViewDelegate?
    
    var data: [ListCellConfigurator] = [] {
        didSet {
            delegate?.needsReload()
        }
    }
    
    private var type: HomeCellType!
    
    init(type: HomeCellType) {
        self.type = type
        
//        generateTestDataForLists()
        getListData(byType: type)
    }
    
    var viewTitle: String {
        return type.title().capitalized
    }
}

extension ListViewModel {
    
    private func getListData(byType type: HomeCellType) {
        RealmService.fetchObjects(Lift.self) { (objects) in
            self.buildListData(with: objects)
        }
    }
    
    private func buildListData(with items: [Object]) {
        var data: [ListCellConfigurator] = []
        
        for item in items {
            if let liftItem = item as? Lift {
                let cellViewModel = ListCellViewModel(title: liftItem.name)
                let configurator = ListCellConfigurator(viewModel: cellViewModel)
                data.append(configurator)
            }
        }
        
        self.data = data
    }
    
    private func generateTestDataForLists() {
        let newLift = Lift()
        newLift.name = "Bench Press"
        newLift.currentWeight = 165
        newLift.goalWeight = 185
        newLift.reps = 12
        newLift.typeEnum = .barbell
        
        RealmService.createObject(newLift)
    }
}
