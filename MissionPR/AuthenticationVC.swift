//
//  AuthenticationVC.swift
//  MissionPR
//
//  Created by Lane Faison on 5/30/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthenticationVC: UIViewController {
    
    @IBOutlet weak var enterBtn: RoundedOutlineButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func useTouchIdPressed(_ sender: Any) {
        
        enterBtn.backgroundColor = UIColor(red: 3/255, green: 169/255, blue: 244/255, alpha: 1.0)
        
        let authenticationContext = LAContext()
        var error: NSError?
        
        if authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // Touch ID, navigating to success VC, handling errors
            authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "For your privacy, this app is secured with Touch ID.", reply: { (success, error) in
                
                if success {
                    // Navigate to the success VC
                    self.navigateToAuthenticatedVC()
                } else {
                    if let error = error as NSError? {
                        // Display an error of a specific type
                        let message = self.errorMessageForLAErrorCode(errorCode: error.code)
                        self.showAlertViewAfterEvaluatingPolicyWithMessage(message: message)
                    }
                }
            })
        } else {
            showAlertViewForNoBiometrics()
            return
        }
    }
    
    @IBAction func btnTouchDown(_ sender: UIButton) {
        
        if sender == enterBtn {
            
            enterBtn.backgroundColor = UIColor(red: 169/255, green: 253/255, blue: 0, alpha: 1.0)
        }
    }
    
    func showAlertViewAfterEvaluatingPolicyWithMessage(message: String) {
        showAlertWithTitle(title: "Error", message: message)
    }
    
    func errorMessageForLAErrorCode(errorCode: Int) -> String {
        var message = ""
        
        switch errorCode {
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
        case LAError.touchIDLockout.rawValue:
            message = "Too many failed attempts"
        case LAError.touchIDNotAvailable.rawValue:
            message = "Touch ID is not available on this device"
        case LAError.userCancel.rawValue:
            message = "The user cancelled"
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
        default:
            message = "Did not find error on LAError object"
        }
        return message
    }
    
    func navigateToAuthenticatedVC() {
        if let loggedInVC = storyboard?.instantiateViewController(withIdentifier: "LoggedInVC") {
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(loggedInVC, animated: true)
            }
        }
    }
    
    func showAlertViewForNoBiometrics() {
        showAlertWithTitle(title: "Error", message: "This device does not have a Touch ID sensor.")
    }
    
    func showAlertWithTitle(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertVC.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}

