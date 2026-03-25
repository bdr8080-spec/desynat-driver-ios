//
//  HomeModel.swift
//  DesynatDriver
//
//  Created by fluper on 04/12/25.
//

import Foundation

// MARK: - UserAvailability
struct UserAvailability: Codable {
    let id: Int?
    let profilePic: String?
    let fullNameEnglish, fullNameArabic, email, countryCode: String?
    let mobile, password, unhashedPassword, addressLine1: String?
    let addressLine2, city, state, dataLet: String?
    let long: String?
    let countryID, zoneID: Int?
    let otp, otpVerify: String?
//    let deviceType: String?
    let deviceToken: String?
    let vehicleName, vehicleRegNo, documentInformation, status: String?
    let onDuty: Int?
    let createdAt, updatedAt: String?

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
        case dataLet = "let"
        case long
        case countryID = "country_id"
        case zoneID = "zone_id"
        case otp
        case otpVerify = "otp_verify"
//        case deviceType = "device_type"
        case deviceToken = "device_token"
        case vehicleName = "vehicle_name"
        case vehicleRegNo = "vehicle_reg_no"
        case documentInformation = "document_information"
        case status
        case onDuty = "on_duty"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}



// MARK: - UserProfileData
struct UserProfileData: Codable {
    let id: Int?
    let profilePic: String?
    let fullNameEnglish, fullNameArabic, email, countryCode: String?
    let mobile, password, unhashedPassword, addressLine1: String?
    let addressLine2, city, state, latitude: String?
    let long: String?
    let countryID, zoneID: Int?
//    let deviceType: Int?
    let otp, otpVerify: String?
    let deviceToken: String?
    let vehicleName, vehicleRegNo, documentInformation, status: String?
    let onDuty, createdAt: String?
    let updatedAt: String?
    let vehicleImage, identityProof, drivingLicense, vehicleInsurance: [DrivingLicense]?
    let pollutionPaper, registrationCertificate: [DrivingLicense]?
    let zoneInfo: ZoneInfo?

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
        case latitude = "let"
        case long
        case countryID = "country_id"
        case zoneID = "zone_id"
        case otp
        case otpVerify = "otp_verify"
//        case deviceType = "device_type"
        case deviceToken = "device_token"
        case vehicleName = "vehicle_name"
        case vehicleRegNo = "vehicle_reg_no"
        case documentInformation = "document_information"
        case status
        case onDuty = "on_duty"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case vehicleImage = "vehicle_image"
        case identityProof = "identity_proof"
        case drivingLicense = "driving_license"
        case vehicleInsurance = "vehicle_insurance"
        case pollutionPaper = "pollution_paper"
        case registrationCertificate = "registration_certificate"
        case zoneInfo = "zone_info"
    }
}

// MARK: - DrivingLicense
struct DrivingLicense: Codable {
    let id, deliveryBoyID: Int?
    let documentType: String?
    let documentPath: String?
    let isFront, status: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case deliveryBoyID = "delivery_boy_id"
        case documentType = "document_type"
        case documentPath = "document_path"
        case isFront = "is_front"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - ZoneInfo
struct ZoneInfo: Codable {
    let id, countryID, cityID: Int?
    let nameEnglish, nameArabic: String?
//    let coordinates: [Coordinate]?
    let status: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case countryID = "country_id"
        case cityID = "city_id"
        case nameEnglish = "name_english"
        case nameArabic = "name_arabic"
//        case coordinates
             case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Coordinate
struct Coordinate: Codable {
    let lat, lng: Double?
}
