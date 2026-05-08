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
      txtMobile.delegate = self
      txtEmailAddress.delegate = self
        txtCountryCode.text = countryCode
    }
    
    @IBAction func btnTapCountryCode(_ sender: UIButton) {
//        let countryNames = viewModel.countryList.map { country -> String in
//            let name = country.name ?? ""
//            let dialCode = country.dialCode ?? ""
//            let flag = country.flag ?? "🇰🇼"
//            return "\(flag)  \(name) (\(dialCode))"
//        }
        
        let countryNames = viewModel.countryList.map { country -> String in
                    let isArabic = AppLanguageManager.shared.currentLanguage == .ar
                    let name = isArabic ? (country.nameAr ?? country.name ?? "") : (country.name ?? "")
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
        
        // ❌ Block any space character for ALL textfields
        if string == " " {
            return false
        }
        
        // Safely unwrap
        guard let currentText = textField.text else { return true }
        
        // New updated text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // ❌ Block leading space
        if updatedText.hasPrefix(" ") {
            return false
        }
        
        var validation: StringValidation?
        
        // -------------------------------------
        // Email validation
        // -------------------------------------
        if textField == txtEmailAddress {
            validation = StringValidation(string: updatedText,
                                          characterCount: 55,
                                          validation: .emailId)
        }
        
        // -------------------------------------
        // Mobile number validation
        // -------------------------------------
        else if textField == txtMobile {
            validation = StringValidation(string: updatedText,
                                          characterCount: 15,
                                          validation: .mobileNo)
        }
        
        // Validate
        if let validation = validation {
            return validation.validate()
        }
        
        return true
    }
}
