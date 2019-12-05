//
//  StoryboardController.swift
//  MissionPR
//
//  Created by Lane Faison on 12/4/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

public protocol StoryboardController {
    static var storyboardName: String { get }
}

extension StoryboardController {
    
    /// Name of the storyboard - Defaults to the class name
    public static var storyboardName: String {
        return String(describing: Self.self)
    }
    
    /// Identifier for the view controller - Defaults to the class name
    public static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
    
    fileprivate static var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: nil)
    }
}

extension StoryboardController where Self: UIViewController {
    
    /// Instantiates a view controller with the given storyboard ID from the given board
    ///
    /// - Parameters
    ///   - storyboardID: Identifier for the view controller in the storyboard. Defaults to the static storyboardIdentifer property
    ///   - fromStoryboard: Storyboard containing the view controller. Defaults to the static storyboard property
    /// - Returns: View controller instance from storyboard
    static func instantiate(withIdentifier storyboardID: String = storyboardIdentifier, fromStoryboard: UIStoryboard = storyboard) -> Self {
        return fromStoryboard.instantiateViewController(identifier: storyboardID) as! Self
    }
    
    static func instantiateFromNib(withIdentifier nibID: String = storyboardIdentifier) -> Self {
        return Self.init(nibName: nibID, bundle: nil)
    }
}

extension UIViewController: StoryboardController {}
