//
//  ForgotPasswordViewController.swift
//  DesynatUser
//
//  Created by Rakhi Kumari on 23/10/25.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    private lazy var viewModel = ForgotPasswordViewModel(hostVC:self)
    @IBOutlet weak var imgEmail: UIImageView!
    @IBOutlet weak var imgMobile: UIImageView!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtCountryCode: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    var mobileIsSelected: Bool? = true
    var countryCode:String = "+965"
    var type = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        emailView.isHidden = true
        viewModel.countryListApi()
        txtCountryCode.text = countryCode
    }
    
    @IBAction func btnTapCountryCode(_ sender: UIButton) {
        let countryNames = viewModel.countryList.map { country -> String in
            let name = country.name ?? ""
            let dialCode = country.dialCode ?? ""
            let flag = country.flag ?? "🇰🇼"
            return "\(flag)  \(name) (\(dialCode))"
        }

        kSharedAppDelegate.dropDown(dataSource: countryNames, anchorView: sender) { index, item in
            let selectedCountry = self.viewModel.countryList[index]
            let code = selectedCountry.dialCode ?? "+965"
            self.txtCountryCode.text = code
            self.countryCode = code
        }
    }
    
    @IBAction func continueDidTapped(_ sender: Any) {
        if viewModel.validFields(mobileIsSelected:mobileIsSelected ?? false){
            viewModel.forgotPasswordApi()
        }
    }
    
    @IBAction func backDidTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func mobileNumberDidTapped(_ sender: Any) {
        imgMobile.image = UIImage(named: "radioSelected")
        imgEmail.image = UIImage(named: "radioUnselected")
        mobileView.isHidden = false
        emailView.isHidden = true
        self.type = 0
        mobileIsSelected = true
    }
    
    @IBAction func emailDidTapped(_ sender: Any) {
        imgEmail.image = UIImage(named: "radioSelected")
        imgMobile.image = UIImage(named: "radioUnselected")
        mobileView.isHidden = true
        emailView.isHidden = false
        self.type = 1
        mobileIsSelected = false
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        // Safely unwrap the current text
        guard let currentText = textField.text else { return true }
        
        // Construct the updated text after the change
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // Prevent leading space
        if updatedText.hasPrefix(" ") {
            return false
        }
        
        var validation: StringValidation?
        
        // Validate email
        if textField == txtEmailAddress {
            validation = StringValidation(string: updatedText, characterCount: 55, validation: .emailId)
        }else if textField == txtMobile {
            validation = StringValidation(string: updatedText, characterCount: 15, validation: .mobileNo)
        }
        
        // Perform validation if applicable
        if let validation = validation {
            return validation.validate()
        }
        
        return true
    }
}
