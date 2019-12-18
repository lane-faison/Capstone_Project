//
//  BaseViewController.swift
//  MissionPR
//
//  Created by Lane Faison on 12/17/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBackButton()
    }
    
    private func updateBackButton() {
        let backButton = UIBarButtonItem(image: AppImage.get(.arrowLeft), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .primaryTextColor
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
