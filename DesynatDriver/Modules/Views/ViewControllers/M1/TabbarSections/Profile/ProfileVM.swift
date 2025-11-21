//
//  ProfileVM.swift
//  DesynatDriver
//
//  Created by Mohd Faizan on 21/11/25.
//

import Foundation
import UIKit

class ProfileVM:NSObject{
    private var hostVC:ProfileVC
    
    init(hostVC: ProfileVC) {
        self.hostVC = hostVC
    }
    
    //Mark:->LogoutApi
    func logoutApi(){
        WebService.sharedInstance.logoutService { user in
            kSharedSceneDelegate.logoutUser()
        }
    }
}
