//
//  EditProfileViewModel.swift
//  DesynatDriver
//
//  Created by fluper on 04/12/25.
//

import Foundation
import UIKit

class EditProfileViewModel:NSObject{
    private var hostVC: EditProfileViewController
  var zoneListData: [DriverZoneList] = []
  
    init(hostVC: EditProfileViewController) {
        self.hostVC = hostVC
    }
    
    // Mark: uploadDocument
  
    func uploadDocument(file: Any, isImage: Bool, completion: @escaping(String) -> Void) {
        let param: MultipartUpload = MultipartUpload(fileName: "image", file: file, mimeType: isImage ? .image : .pdf)
        WebService.sharedInstance.uploadFile(withParams: param) { url, msg, code in
            completion(url)
        }
    }
  
  func getAllZone(completion: (() -> Void)? = nil) {
    WebService.sharedInstance.getAllZone(){ [weak self] response in
      guard let self = self else { return }
      zoneListData = response
      completion?()
    }
  }
    
    //Mark->:changeMobileNumberApi
//    func changeMobileNumberApi(){
//        let param:[String:Any] = [
//               "for":"mobile",
//               "country_code":self.hostVC.txtCountryCode.text ?? "",
//               "mobile":self.hostVC.txtMobileNumber.text ?? "",
//               "type":"0"
//               
//           ]
//       
//        WebService.sharedInstance.changeMobileNumberService(withParams:param) { user in
//            let vc = OTPViewController.instantiate(fromAppStoryboard: .Main)
//            vc.comingReason = .changeOldMobileNumber
//            vc.id = "\(user.id ?? 0)"
//            vc.isEnteredPhoneNumber = true
//            vc.phoneNumber = self.hostVC.txtMobileNumber.text?.trimmed() ?? ""
//            vc.countryCode = self.hostVC.countryCode
//            vc.callBackForProfileDetails = { mobile,countryCode,_ in
//                self.hostVC.txtMobileNumber.text = mobile
//                self.hostVC.txtCountryCode.text = countryCode
//                print("mobile:\(mobile)")
//                print("countryCode:\(countryCode)")
//            }
//            self.hostVC.navigationController?.pushViewController(vc, animated: true)
//            
//        }
//    }
    
    //Mark->:changeEmailApi
//    func changeEmailApi(){
//        let param:[String:Any] = [
//               "for":"email",
//               "email":self.hostVC.txtEmail.text ?? "",
//               "type":"0"
//               
//           ]
//         
//        WebService.sharedInstance.changeMobileNumberService(withParams:param) { user in
//            let vc = OTPViewController.instantiate(fromAppStoryboard: .Main)
//            vc.comingReason = .changeOldEmail
//            vc.id = "\(user.id ?? 0)"
//            vc.isEnteredPhoneNumber = false
//            vc.phoneNumber = self.hostVC.txtEmail.text?.trimmed() ?? ""
//            vc.callBackForProfileDetails = { _, _, email in
//                self.hostVC.txtEmail.text = email
//                print("email:\(email)")
//            }
//            self.hostVC.navigationController?.pushViewController(vc, animated: true)
//            
//        }
//    }
    
//    func updateProfileApi(){
//        let param:[String:Any] = [
//            "full_name":self.hostVC.txtFullName.text ?? "",
//            "image":self.hostVC.selectedProfileImageUrl,
//            "country_code":self.hostVC.txtCountryCode.text ?? "",
//            "mobile":self.hostVC.txtMobileNumber.text ?? "",
//            "email":self.hostVC.txtEmail.text ?? ""
//        ]
//        WebService.sharedInstance.updateProfileService(withParams:param) { user in
//            self.hostVC.navigationController?.popViewController(animated: true)
//        }
//    }
    
}
