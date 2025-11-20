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
    
    init(hostVC: LoginViewController) {
        self.hostVC = hostVC
    }
    
    //Mark:->LoginApi
    func loginApi(){
        let params:[String:Any] = ["":""
            
        ]
        
        WebService.sharedInstance.loginService(withParams:params) { user in
            let vc = TabBarVC.instantiate(fromAppStoryboard:.Home)
            self.hostVC.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
