//
//  AuthenticationVC.swift
//  MissionPR
//
//  Created by Lane Faison on 5/30/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit

class AuthenticationVC: UIViewController {
    
    @IBOutlet weak var enterBtn: RoundedOutlineButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func useTouchIdPressed(_ sender: Any) {
        enterBtn.backgroundColor = UIColor(red: 3/255, green: 169/255, blue: 244/255, alpha: 1.0)
        enterBtn.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1.0), for: .normal)
    }
    
    @IBAction func btnTouchDown(_ sender: UIButton) {
        
        if sender == enterBtn {
            enterBtn.backgroundColor = UIColor(red: 169/255, green: 253/255, blue: 0, alpha: 1.0)
            enterBtn.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1.0), for: .normal)
        }
    }
}

