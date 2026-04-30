//
//  LoginViewModel.swift
//  DesynatDriver
//
//  Created by Mohd Faizan on 20/11/25.
//

import Foundation
import UIKit

class LoginViewModel:NSObject{
    private var hostVC:LoginViewController
    var countryList:[CountryModel] = []
    
    init(hostVC: LoginViewController) {
        self.hostVC = hostVC
    }
    
    func validFields() -> Bool {
        var errorMessage: AlertConstant = .none
        let input = String.getString(hostVC.emailTextField.text).trimmingCharacters(in: .whitespacesAndNewlines)
        
        if input.isEmpty {
            errorMessage = .EnterEmailOrMobileNumber
        } else if input.isEmail() {
            if !input.isValidEmail() {
                errorMessage = .EnterValidEmailAddress
            }
        } else if input.isPhoneNumber() {
            if !input.isValidPhoneNumber() {
                errorMessage = .validMobileNumber
            }
        } else {
            errorMessage = .EnterValidEmailorMobile
        }
        
        let password = String.getString(hostVC.txtPassword.text).trimmingCharacters(in: .whitespacesAndNewlines)
        
      if errorMessage == .none {
          if password.isEmpty {
              errorMessage = .EnterPassword
          }else if password.count < 6 {
              errorMessage = .PasswordMinLength   // <-- Add this in AlertConstant
          }
      }
        
        if errorMessage != .none {
            hostVC.showAlert(msg: errorMessage.rawValue.localiz())
        }
        
        hostVC.view.endEditing(true)
        return errorMessage == .none
    }
    
    //Mark:->LoginApi
    func loginApi(){
        var params:[String:Any] = [:]
        
        if self.hostVC.type == 1{
            params = [
                APIKeys.emailOrMobile:self.hostVC.emailTextField.text ?? "",
                APIKeys.password:self.hostVC.txtPassword.text ?? "",
                APIKeys.type:self.hostVC.type,
                "device_type": 1,//0 web 1 ios 2 andriod
                "fcm_token": kSharedUserDefaults.retrieveModelFor(key: .deviceToken, model: String.self) ?? ""
            ]
        }else{
            params = [
                APIKeys.emailOrMobile:self.hostVC.emailTextField.text ?? "",
                APIKeys.countryCode:self.hostVC.countryCode,
                APIKeys.password:self.hostVC.txtPassword.text ?? "",
                APIKeys.type:self.hostVC.type,
                "device_type": 1,//0 web 1 ios 2 andriod
                "fcm_token": kSharedUserDefaults.retrieveModelFor(key: .deviceToken, model: String.self) ?? ""
            ]
        }
        
        WebService.sharedInstance.loginService(withParams:params) { user in
            UserDefaults.standard.set("yes", forKey: "isLogin")
            let vc = TabBarVC.instantiate(fromAppStoryboard:.Home)
            self.hostVC.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func countryListApi(){
        WebService.sharedInstance.countryListService { list in
            self.countryList = list
        }
    }
    
}
