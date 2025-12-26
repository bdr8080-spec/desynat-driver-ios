//
//  ResetPasswordViewModel.swift
//  DesynatDriver
//
//  Created by Mohd Faizan on 21/11/25.
//

import Foundation
import UIKit

class ResetPasswordViewModel:NSObject{
    private var hostVC:ResetPasswordViewController
    
    init(hostVC: ResetPasswordViewController) {
        self.hostVC = hostVC
    }
    
    //Mark:->createPasswordApi
    func createPasswordApi(){
        let params:[String:Any] = [
            APIKeys.userId:self.hostVC.userId,
            APIKeys.password:self.hostVC.txtCreatePass.text ?? "",
            APIKeys.confirmPassword:self.hostVC.txtConfirmPass.text ?? ""
            
        ]
        WebService.sharedInstance.createPasswordService(withParams:params) { user in
            let vc = RegisterationSuccessViewController.instantiate(fromAppStoryboard: .Main)
            vc.comingReason = .passwordUpdated
            vc.callBackDismiss = {
                self.hostVC.navigationController?.popToViewController(ofClass: LoginViewController.self, animated: true)
            }
            self.hostVC.navigationController?.present(vc, animated: true)
        }
    }
}
