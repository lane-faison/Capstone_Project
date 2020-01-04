//
//  CreateGoalViewController.swift
//  MissionPR
//
//  Created by Lane Faison on 12/21/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

final class CreateGoalViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    static func instantiate(with viewModel: CreateGoalViewModel) -> CreateGoalViewController {
        let createGoalViewController = CreateGoalViewController.instantiate()
        viewModel.delegate = createGoalViewController
        createGoalViewController.viewModel = viewModel
        return createGoalViewController
    }
    
    var viewModel: CreateGoalViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Exercise"
        
        updateNavigationButtons()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        registerTableViewCells()
    }
    
    private func updateNavigationButtons() {
        hideBackButton()
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        cancelButton.tintColor = .primaryTextColor
        navigationItem.rightBarButtonItem = cancelButton
    }
    
    private func registerTableViewCells() {
        guard let viewModel = viewModel else { return }
        
        for model in viewModel.data {
            model.register(in: tableView)
        }
    }
    
    @objc private func cancelButtonTapped() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate

extension CreateGoalViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - UITableViewDataSource

extension CreateGoalViewController: UITableViewDataSource {
    
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

extension CreateGoalViewController: CreateGoalViewDelegate {
    func pickerButtonTapped() {
        print("HI")
    }
}
