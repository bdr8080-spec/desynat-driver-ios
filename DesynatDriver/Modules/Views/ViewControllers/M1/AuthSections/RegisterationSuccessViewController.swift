//
//  RegisterationSuccessViewController.swift
//  DesynatUser
//
//  Created by Rakhi Kumari on 23/10/25.
//

import UIKit

class RegisterationSuccessViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    var callBackDismiss: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.dismiss(animated: true) {
                self.callBackDismiss?()
            }
        }
    }
    
}

//enum ComingReasonAtRegisterationSuccess {
//    case passwordUpdated
//}
