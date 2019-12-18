//
//  ListViewController.swift
//  MissionPR
//
//  Created by Lane Faison on 12/17/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

class ListViewController: BaseViewController {
    
    static func instantiate(with viewModel: ListViewModel) -> ListViewController {
        let listViewController = ListViewController.instantiate()
        listViewController.viewModel = viewModel
        return listViewController
    }
    
    var viewModel: ListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel?.viewTitle
    }
}
