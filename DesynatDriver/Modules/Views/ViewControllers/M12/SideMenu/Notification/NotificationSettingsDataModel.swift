//
//  NotificationSettingsDataModel.swift
//  DesynatDriver
//
//  Created by fluper_mac3 on 17/04/26.
//

import Foundation

// MARK: - NotificationSettingsDataModel
struct NotificationSettingsDataModel: Codable {
    let id: Int?
    let profilePic: String?
    let fullNameEnglish, fullNameArabic, email, countryCode: String?
    let mobile, password, unhashedPassword, addressLine1: String?
    let addressLine2, city, state: String?
    let countryID, zoneID: Int?
    let otp, otpVerify: String?
    let vehicleName, vehicleRegNo, documentInformation, status: String?
    let onDuty, createdAt, updatedAt: String?
    let notification, appNotification: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case profilePic = "profile_pic"
        case fullNameEnglish = "full_name_english"
        case fullNameArabic = "full_name_arabic"
        case email
        case countryCode = "country_code"
        case mobile, password
        case unhashedPassword = "unhashed_password"
        case addressLine1 = "address_line1"
        case addressLine2 = "address_line2"
        case city, state
        case countryID = "country_id"
        case zoneID = "zone_id"
        case otp
        case otpVerify = "otp_verify"
        case vehicleName = "vehicle_name"
        case vehicleRegNo = "vehicle_reg_no"
        case documentInformation = "document_information"
        case status
        case onDuty = "on_duty"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case notification
        case appNotification = "app_notification"
    }
}
