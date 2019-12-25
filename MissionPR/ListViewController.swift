//
//  ListViewController.swift
//  MissionPR
//
//  Created by Lane Faison on 12/17/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

class ListViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    static func instantiate(with viewModel: ListViewModel) -> ListViewController {
        let listViewController = ListViewController.instantiate()
        listViewController.viewModel = viewModel
        return listViewController
    }
    
    var viewModel: ListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel?.viewTitle
        addRightBarButtonItem()
        
        tableView.dataSource = self
        viewModel?.delegate = self
        
        registerTableViewCells()
    }
    
    private func addRightBarButtonItem() {
        let iconImage = AppImage.get(.add)?.tinted(tintColor: .primaryTextColor)
        let button = UIBarButtonItem(image: iconImage, style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func addButtonTapped() {
        let viewModel = CreateGoalViewModel()
        let viewController = CreateGoalViewController.instantiate(with: viewModel)
        presentViewControllerAsPopup(viewController)
    }
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = viewModel?.data[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: model.self).reuseId, for: indexPath)
        model.configure(cell: cell)
        return cell
    }
}

extension ListViewController: ListViewDelegate {
    
    func needsReload() {
        // Reload tableView
    }
}

// MARK: - TableView Helpers

extension ListViewController {
    
    private func registerTableViewCells() {
        guard let data = viewModel?.data else { return }
        for model in data {
            model.register(in: tableView)
        }
    }
}
