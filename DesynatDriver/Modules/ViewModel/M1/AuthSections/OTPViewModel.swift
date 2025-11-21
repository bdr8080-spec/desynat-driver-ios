//
//  OTPViewModel.swift
//  DesynatDriver
//
//  Created by Mohd Faizan on 21/11/25.
//

import Foundation
import UIKit

class OTPViewModel:NSObject{
    private var hostVC:OTPViewController
    
    init(hostVC: OTPViewController) {
        self.hostVC = hostVC
    }
    
    //Mark:->otpVerifyApi
    func otpVerifyApi(){
        let params:[String:Any] = [
            APIKeys.userId:self.hostVC.userId,
            APIKeys.otp:self.hostVC.otpDigits
        ]
        WebService.sharedInstance.otpVerificationService(withParams:params) { user in
            let vc = ResetPasswordViewController.instantiate(fromAppStoryboard:.Main)
            vc.userId = user.id ?? 0
            self.hostVC.navigationController?.pushViewController(vc, animated:true)
        }
    }
    
    //Mark:->resendOtpApi
    func resendOtpApi(){
        var params:[String:Any] = [:]
        
        if self.hostVC.type == 0{
            params = [
                APIKeys.type:self.hostVC.type,
                APIKeys.emailOrMobile:self.hostVC.mobile,
                APIKeys.countryCode:self.hostVC.countryCode
            ]
        }else{
           params = [
            APIKeys.type:self.hostVC.type,
            APIKeys.emailOrMobile:self.hostVC.email
           ]
        }
        
        WebService.sharedInstance.resendOtpService(withParams:params) { user in
            self.hostVC.startTimer()
        }
    }
}
