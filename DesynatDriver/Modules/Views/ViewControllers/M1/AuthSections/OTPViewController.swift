//
//  OTPViewController.swift
//  DesynatUser
//
//  Created by Rakhi Kumari on 23/10/25.
//

import UIKit

class OTPViewController: UIViewController {

    var comingReason: ComingReasonAtOTPScreen = .forgotPassword
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func backDidTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func verifyDidTapped(_ sender: Any) {
        switch comingReason {
        case .forgotPassword:
            let vc = ResetPasswordViewController.instantiate(fromAppStoryboard: .Main)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

enum ComingReasonAtOTPScreen {
    case forgotPassword
}
