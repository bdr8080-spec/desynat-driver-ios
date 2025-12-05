//
//  StringConstant.swift
//  ChorApp
//
//  Created by Developer on 05/12/23.
//

import Foundation

enum StringConstant: String {
    case ok                         = "Ok"
    case done                       = "Done"
    case cancel                     = "Cancel"
    
    func value() -> String {
        return self.rawValue
    }
}

enum AlertConstant: String {
    case none = ""
    /// Network validation
    case noInternet                 = "Network connection failed. Please check your internet and try again."
    case noStatusCode               = "No status code found"
    case noResponse                 = "No response data"
    case wentWrong                  = "Something went wrong"
    case noDataFound                = "No data found"
    case unableToDecode             = "Unable to decode data"
    case sessionExpired             = " Your session has expired. Please log in again."
    case imageMimeNotSame           = "Mime type and file are not of same data type"
    case videoMimeNotSame           = "Video Mime type and file are not URL"
    case decodingError              = "Failed to decode response"
    
    ///Validation Error Message
    case EnterEmailOrMobileNumber   = "Please Enter Mobile Number or Email Address"
    case EnterEmail                 = " Please Enter Email Address"
    case EnterMobileNumber          = "Please Enter Mobile Number"
    case EnterValidEmailAddress     = " Please Enter Valid Email Address"
    case validMobileNumber          = "Please enter valid mobile number"
    case EnterValidEmailorMobile    = "Please Enter Valid Email ID or Mobile Number"
    case EnterPassword              = "Please enter password"
  case PasswordMinLength = "Password must be at least 6 characters long"
  case EnterEmailAddress          = "Please enter emaill address"
  
  case uploadProfilePicture = "Please upload profile image"
  case enterFullNameEnglish = "Please enter full name in english"
  case enterFullNameArabic = "Please enter full name in arabic"
  case enterFirstName = "Please enter first name"
  case enterLastName = "Please enter last name"
  
  case enterAddress1 = "Please select Address Line 1"
  case enterAddress2 = "Please enter Address Line 2"
  case enterHouseNumber = "Please enter house no./ Building no/Area"
  case enterBlock = "Please enter block/street"
  case enterCity = "Please enter city/district"
  case enterState = "Please enter state"
  case selectZone = "Please select zone"
  case enterVehicleName = "Please enter vehicle name"
  case enterVehicleReg = "Please enter vehicle registration"
  
  case uploadVehicleFront = "Please upload vehicle image (front)"
  case uploadVehicleBack = "Please upload vehicle image (back)"
  
  case uploadIdentityFront = "Please upload identity proof (front)"
  case uploadIdentityBack = "Please upload identity proof (back)"
  
  case uploadDLFront = "Please upload driving license (front)"
  case uploadDLBack = "Please upload driving license (back)"
  
  case uploadInsurance = "Please upload vehicle insurance"
  case uploadPollution = "Please upload pollution paper"
  
  case uploadRCFront = "Please upload RC front image"
  case uploadRCBack = "Please upload RC back image"
  
    func value() -> String {
        return self.rawValue
    }
}

struct MatchCharacterConstant {
    static let capitalAlphabet      = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static let smallAlphabet        = "abcdefghijklmnopqrstuvwxyz"
    static let spacialCharacter     = "@._!#$%^&*()/<>'+,:;=?[]{}|~`-\""
    static let number               = "0123456789"
    static let timing               = number + ":"
    static let cardExpiration       = number + "/"
}
