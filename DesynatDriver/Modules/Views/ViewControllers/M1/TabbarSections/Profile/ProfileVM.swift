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
//        WebService.sharedInstance.logoutService { user in
            kSharedSceneDelegate.logoutUser()
//        }
    }
  
  func populateDataInProfile() {
    hostVC.userNameLaebl.text = driverProfileData?.fullNameEnglish
    hostVC.userEmailLabel.text = driverProfileData?.email
    hostVC.phoneLabel.text = "\(driverProfileData?.countryCode ?? "0") \(driverProfileData?.mobile ?? "")"
    
    hostVC.addressLabel.text = [
      driverProfileData?.addressLine1,
      driverProfileData?.addressLine2,
      driverProfileData?.city,
      driverProfileData?.state
    ]
    .compactMap { $0 }
    .filter { !$0.isEmpty }
    .joined(separator: ", ")
    hostVC.userProfileImageView.setImage(with: driverProfileData?.profilePic)
    hostVC.zoneLabel.text = driverProfileData?.zoneInfo?.nameEnglish
  }
}
