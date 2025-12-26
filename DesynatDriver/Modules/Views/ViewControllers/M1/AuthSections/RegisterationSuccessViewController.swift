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
    var comingReason: ComingReasonAtRegisterationSuccess = .passwordUpdated
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.dismiss(animated: true) {
                self.callBackDismiss?()
            }
        }
        configureUI()
    }
    private func configureUI() {
        switch comingReason {
        case .passwordUpdated:
            descriptionLabel.text = "Password Reset successfully !"
        case .orderDeliveredSuccessfully:
            descriptionLabel.text = "Order delivered successfully"
        case .orderPickedSuccessfully:
            descriptionLabel.text = "Order picked successfully"
        case .orderStatusUpdatedasNotDelivered:
            descriptionLabel.text = "Order Status Updated as Not Delivered"
        }
    }
    
}

enum ComingReasonAtRegisterationSuccess {
    case passwordUpdated
    case orderDeliveredSuccessfully
    case orderPickedSuccessfully
    case orderStatusUpdatedasNotDelivered
}
