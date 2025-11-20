//
//  User.swift
//  DesynatDealer
//
//  Created by Rakhi Kumari on 03/11/25.


struct User: Codable {
    let id: Int?
    let profilePic: String?
    let fullNameEnglish: String?
    let fullNameArabic: String?
    let email: String?
    let countryCode: String?
    let mobile: String?
    let password: String?
    let addressLine1: String?
    let addressLine2: String?
    let city: String?
    let state: String?
    let lat: String?
    let long: String?
    let countryID: Int?
    let zoneID: Int?
    let otp: String?
    let otpVerify: String?
    let deviceType: String?
    let deviceToken: String?
    let vehicleName: String?
    let vehicleRegNo: String?
    let documentInformation: String?
    let status: String?
    let createdAt: String?
    let updatedAt: String?
    let accessToken: String?

    enum CodingKeys: String, CodingKey {
        case id
        case profilePic = "profile_pic"
        case fullNameEnglish = "full_name_english"
        case fullNameArabic = "full_name_arabic"
        case email
        case countryCode = "country_code"
        case mobile
        case password
        case addressLine1 = "address_line1"
        case addressLine2 = "address_line2"
        case city
        case state
        case lat = "let"
        case long
        case countryID = "country_id"
        case zoneID = "zone_id"
        case otp
        case otpVerify = "otp_verify"
        case deviceType = "device_type"
        case deviceToken = "device_token"
        case vehicleName = "vehicle_name"
        case vehicleRegNo = "vehicle_reg_no"
        case documentInformation = "document_information"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case accessToken
    }
}

