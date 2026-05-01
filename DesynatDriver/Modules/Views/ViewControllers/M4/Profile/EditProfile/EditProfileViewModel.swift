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
  
  func validateFields() -> Bool {
    var error: AlertConstant = .none
    
    let mobileInput = String.getString(hostVC.mobileTF.text).trimmingCharacters(in: .whitespacesAndNewlines)
    let emailInput  = String.getString(hostVC.emailTF.text).trimmingCharacters(in: .whitespacesAndNewlines)
    
    if hostVC.profileImageUrl.isEmpty {
      error = .uploadProfilePicture
      
      //    } else if hostVC.firstNameTF.text?.trimmed().isEmpty ?? true {
      //      error = .enterFirstName
      //
      //    } else if hostVC.lastNameTF.text?.trimmed().isEmpty ?? true {
      //      error = .enterLastName
      
    } else if hostVC.fullNameInEnglishTF.text?.trimmed().isEmpty ?? true {
      error = .enterFullNameEnglish
      
    } else if hostVC.fullNameInArabicTF.text?.trimmed().isEmpty ?? true {
      error = .enterFullNameArabic
      
    } else if mobileInput.isEmpty {
      error = .EnterMobileNumber
      
    } else if !mobileInput.isValidPhoneNumber() {
      error = .validMobileNumber
      
    } else if emailInput.isEmpty {
      error = .EnterEmailAddress
      
    } else if !emailInput.isValidEmail() {
      error = .EnterValidEmailAddress
      
    }  else if hostVC.addressLineTF.text?.isEmpty ?? true {
      error = .enterAddress1
      
    } else if hostVC.houseNumberTF.text?.isEmpty ?? true {
      error = .enterAddress2
      
      //    } else if hostVC.blockNumberTF.text?.isEmpty ?? true {
      //      error = .enterBlock
      
    } else if hostVC.cityTF.text?.isEmpty ?? true {
      error = .enterCity
      
    } else if hostVC.stateTF.text?.isEmpty ?? true {
      error = .enterState
      
    } else if hostVC.zoneId == 0 {
      error = .selectZone
      
    }
    
    if error != .none {
        hostVC.showAlert(msg: error.rawValue.localiz())
      return false
    }
    
    return true
  }
  
  func editDriverProfileApi() {
    let params: [String: Any] = [
      "delivery_boy_id": driverProfileData?.id ?? 0,
      "profile_pic": hostVC.profileImageUrl,
      "full_name_english": String.getString(hostVC.fullNameInEnglishTF.text),
      "full_name_arabic": String.getString(hostVC.fullNameInArabicTF.text),
      "email": String.getString(hostVC.emailTF.text),
      "country_code": String.getString(hostVC.countryCodeTF.text),
      "mobile": String.getString(hostVC.mobileTF.text),
      "address_line1": String.getString(hostVC.addressLineTF.text),
      "address_line2": String.getString(hostVC.houseNumberTF.text),
      "city": String.getString(hostVC.cityTF.text),
      "state": String.getString(hostVC.stateTF.text),
      "let": hostVC.latitude ?? 0.0,
      "long": hostVC.longitude ?? 0.0,
      "zone_id": hostVC.zoneId ?? 0,
    ]
    
    WebService.sharedInstance.editDriverDetails(param: params) { (response) in
      DispatchQueue.main.async {
          CommonUtils.showToast(message: "profile updated succesfully".localiz())
        self.hostVC.profileIsUpdated?()
        self.hostVC.navigationController?.popViewController(animated: true)
      }
    }
  }
  
}
