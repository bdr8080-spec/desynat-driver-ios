//
//  ForgotPasswordViewModel.swift
//  DesynatDriver
//
//  Created by Mohd Faizan on 21/11/25.
//

import Foundation
import UIKit

class ForgotPasswordViewModel:NSObject{
    private var hostVC:ForgotPasswordViewController
    var countryList:[CountryModel] = []
    
    init(hostVC: ForgotPasswordViewController) {
        self.hostVC = hostVC
    }
    
    func validFields(mobileIsSelected: Bool) -> Bool {
        var errorMessage: AlertConstant = .none
        if mobileIsSelected {
            let input = String.getString(hostVC.txtMobile.text).trimmingCharacters(in: .whitespacesAndNewlines)
            if input.isEmpty {
                errorMessage = .EnterMobileNumber
            }else if !input.isValidPhoneNumber() {
                errorMessage = .validMobileNumber
            }
        } else {
            let input = String.getString(hostVC.txtEmailAddress.text).trimmingCharacters(in: .whitespacesAndNewlines)
            if input.isEmpty {
                errorMessage = .EnterEmail
            } else if !input.isValidEmail() {
                errorMessage = .EnterValidEmailAddress
            }
        }
        
        if errorMessage != .none {
            hostVC.showAlert(msg: errorMessage.rawValue.localiz())
        }
        
        hostVC.view.endEditing(true)
        return errorMessage == .none
    }
    
    //Mark:->forgotPasswordAPi
    func forgotPasswordApi(){
        var params:[String:Any] = [:]
        
        if self.hostVC.type == 0{
            params = [
                APIKeys.type:self.hostVC.type,
                APIKeys.countryCode:self.hostVC.countryCode,
                APIKeys.mobile:self.hostVC.txtMobile.text ?? "",
                
            ]
        }else{
            params = [
                APIKeys.type:self.hostVC.type,
                APIKeys.email:self.hostVC.txtEmailAddress.text ?? ""
            ]
        }
        
        WebService.sharedInstance.forgotPasswordService(withParams:params) { user in
            let vc = OTPViewController.instantiate(fromAppStoryboard: .Main)
            vc.type = self.hostVC.type
            vc.countryCode = user.countryCode ?? ""
            vc.mobile = user.mobile ?? ""
            vc.email = user.email ?? ""
            vc.userId = user.id ?? 0
            self.hostVC.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func countryListApi(){
        WebService.sharedInstance.countryListService { list in
            self.countryList = list
        }
    }
}
