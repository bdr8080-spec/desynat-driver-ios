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
