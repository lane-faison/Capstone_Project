//
//  UIViewController+Extensions.swift
//  MissionPR
//
//  Created by Lane Faison on 12/21/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentViewControllerAsPopup(_ viewController: UIViewController) {
        let newNavigationController = UINavigationController(rootViewController: viewController)
        newNavigationController.modalPresentationStyle = .fullScreen
        navigationController?.present(newNavigationController, animated: true, completion: nil)
    }
}
