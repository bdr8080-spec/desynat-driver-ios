//
//  DelivieriesModel.swift
//  DesynatDriver
//
//  Created by Chandra Prakash on 24/12/25.
//

import Foundation
// MARK: - DeliveryListModel
struct DeliveryListModel: Codable {
    var currentPage: Int?
    var data: [DeliveryList]?
    var firstPageURL: String?
    var from, lastPage: Int?
    var lastPageURL: String?
    var links: [Link]?
    var nextPageURL: String?
    var path: String?
    var perPage: Int?
    var prevPageURL: String?
    var to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case links
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}


// MARK: - DeliveryList
struct DeliveryList: Codable {
    var id, orderID, userID, productID: Int?
    var variantsID, quantity: Int?
    var amount, status, createdAt, updatedAt: String?
    var returnType, rEApprove: String?
    var returnReason, returnImage, exchangeReason, exchangeNewSize: String?
    var exchangeOldSize: String?
    var paymentStatus, deliveryStatus, deliveryBoyID, assignStatus: String?
    var assignDate: String?
    var cancelReason: String?
    var isPicked: String?
    var notDeliveredReason: String?
    var distance: Int?
    var order: Order?
    var productDetails: ProductDetails?
    var variationDetails: VariationDetails?

    enum CodingKeys: String, CodingKey {
        case id
        case orderID = "order_id"
        case userID = "user_id"
        case productID = "product_id"
        case variantsID = "variants_id"
        case quantity, amount, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case returnType = "return_type"
        case rEApprove = "r_e_approve"
        case returnReason = "return_reason"
        case returnImage = "return_image"
        case exchangeReason = "exchange_reason"
        case exchangeNewSize = "exchange_new_size"
        case exchangeOldSize = "exchange_old_size"
        case paymentStatus = "payment_status"
        case deliveryStatus = "delivery_status"
        case deliveryBoyID = "delivery_boy_id"
        case assignStatus = "assign_status"
        case assignDate = "assign_date"
        case cancelReason = "cancel_reason"
        case isPicked = "is_picked"
        case notDeliveredReason = "not_delivered_reason"
        case distance, order
        case productDetails = "product_details"
        case variationDetails = "variation_details"
    }
}

// MARK: - Order
struct Order: Codable {
    var id: Int?
    var orderID: String?
    var userID, deliveryAddress: Int?
    var totalMrp, discountMrp: String?
    var promocodeStatus: String?
    var promocodeID, promocodeValue: String?
    var giftcardAmount: String?
    var giftcardID: String?
    var shippingFees, tax: String?
    var walletAmount: String?
    var totalAmount, paymentStatus, paymentMethod, deliveryStatus: String?
    var transactionID: String?
    var deliveryBoyID, assignStatus, assignDate, createdAt: String?
    var updatedAt: String?
    var cancelReason: String?
    var deliveryDetails: DeliveryDetails?

    enum CodingKeys: String, CodingKey {
        case id
        case orderID = "order_id"
        case userID = "user_id"
        case deliveryAddress = "delivery_address"
        case totalMrp = "total_mrp"
        case discountMrp = "discount_mrp"
        case promocodeStatus = "promocode_status"
        case promocodeID = "promocode_id"
        case promocodeValue = "promocode_value"
        case giftcardAmount = "giftcard_amount"
        case giftcardID = "giftcard_id"
        case shippingFees = "shipping_fees"
        case tax
        case walletAmount = "wallet_amount"
        case totalAmount = "total_amount"
        case paymentStatus = "payment_status"
        case paymentMethod = "payment_method"
        case deliveryStatus = "delivery_status"
        case transactionID = "transaction_id"
        case deliveryBoyID = "delivery_boy_id"
        case assignStatus = "assign_status"
        case assignDate = "assign_date"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case cancelReason = "cancel_reason"
        case deliveryDetails = "delivery_details"
    }
}

// MARK: - DeliveryDetails
struct DeliveryDetails: Codable {
    var id, userID: Int?
    var name: String?
    var mobile, countryCode: String?
    var address: String?
    var houseNo: String?
    var streetNo: String?
    var postalCode: String?
    var city: String?
    var state: State?
    var countryName: String?
    var landmark: String?
    var saveAddressAs, status: Int?
    var latitude, longitude, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case name, mobile
        case countryCode = "country_code"
        case address
        case houseNo = "house_no"
        case streetNo = "street_no"
        case postalCode = "postal_code"
        case city, state
        case countryName = "country_name"
        case landmark
        case saveAddressAs = "save_address_as"
        case status, latitude, longitude
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum Address: String, Codable {
    case the33XH2M3NorthAhmadi = "33XH+2M3,  North Ahmadi"
}

enum City: String, Codable {
    case alAhmadi = "Al Ahmadi"
}

enum CountryName: String, Codable {
    case kuwait = "Kuwait"
    case sector63201309India = "Sector 63, 201309, India"
    case ضاحيةمباركالعبداللهحوليUnknownPincode = "ضاحية مبارك العبدالله, حولي - Unknown Pincode"
}

enum HouseNo: String, Codable {
    case northAhmadi = "NorthAhmadi"
}

enum DeliveryDetailsName: String, Codable {
    case sourabh = "sourabh"
}

enum State: String, Codable {
    case alAhmadiGovernorate = "Al Ahmadi Governorate"
}

enum PromocodeStatus: String, Codable {
    case no = "no"
}

// MARK: - ProductDetails
struct ProductDetails: Codable {
    var id: Int?
    var sellerID, storeID, categoryID, subcategoryID: String?
    var brandID: String?
    var otherEn, otherAr: String?
    var productNameEn, productNameAr, descriptionEn: String?
    var descriptionAr: String?
    var minCardQuantity, maxCardQuantity, productReturn: String?
    var returnDays: String?
    var productExchangable: String?
    var exchangableDays: String?
    var reviewRating, affiliatedProduct: String?
    var affiliatedCommission: String?
    var customizedProduct, readyToShip, cashOnDelivery: String?
    var uploadSizeChart: String?
    var productActiveStatus: Int?
    var createdAt, updatedAt: String?
    var brand: Brand?
    var category: Category?
    var subcategory: Brand?
    var sellerDetails: SellerDetails?

    enum CodingKeys: String, CodingKey {
        case id
        case sellerID = "seller_id"
        case storeID = "store_id"
        case categoryID = "category_id"
        case subcategoryID = "subcategory_id"
        case brandID = "brand_id"
        case otherEn = "other_en"
        case otherAr = "other_ar"
        case productNameEn = "product_name_en"
        case productNameAr = "product_name_ar"
        case descriptionEn = "description_en"
        case descriptionAr = "description_ar"
        case minCardQuantity = "min_card_quantity"
        case maxCardQuantity = "max_card_quantity"
        case productReturn = "product_return"
        case returnDays = "return_days"
        case productExchangable = "product_exchangable"
        case exchangableDays = "exchangable_days"
        case reviewRating = "review_rating"
        case affiliatedProduct = "affiliated_product"
        case affiliatedCommission = "affiliated_commission"
        case customizedProduct = "customized_product"
        case readyToShip = "ready_to_ship"
        case cashOnDelivery = "cash_on_delivery"
        case uploadSizeChart = "upload_size_chart"
        case productActiveStatus = "product_active_status"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case brand, category, subcategory
        case sellerDetails = "seller_details"
    }
}

// MARK: - Brand
struct Brand: Codable {
    var id: Int?
    var nameEnglish: String?
    var nameArabic: String?
    var image: String?
    var status: Int?
    var createdAt, updatedAt: String?
    var categoryID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case nameEnglish = "name_english"
        case nameArabic = "name_arabic"
        case image, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case categoryID = "category_id"
    }
}

enum NameArabic: String, Codable {
    case أديداس = "أديداس"
    case قميصرسمي = "قميص رسمي"
    case كوب = "كوب"
}

// MARK: - Category
struct Category: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var image: String?
    var status: Int?
    var colorCode: String?
    var createdAt: String?
    var updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, description, image, status
        case colorCode = "color_code"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


// MARK: - SellerDetails
struct SellerDetails: Codable {
    var id: Int?
    var profilePic: String?
    var firstName: String?
    var lastName: String?
    var countryCode, mobile: String?
    var email: String?
    var password: String?
    var acceptTerms, otp, otpVerify: String?
    var deviceType, deviceToken: String?
    var adminVerify, storeInformation, bankInformation: String?
    var rejectReason, lang: String?
    var isBlock: Int?
    var affilateCommission: String?
    var createdAt: String?
    var updatedAt: String?
    var storeInfo: StoreInfo?

    enum CodingKeys: String, CodingKey {
        case id
        case profilePic = "profile_pic"
        case firstName = "first_name"
        case lastName = "last_name"
        case countryCode = "country_code"
        case mobile, email, password
        case acceptTerms = "accept_terms"
        case otp
        case otpVerify = "otp_verify"
        case deviceType = "device_type"
        case deviceToken = "device_token"
        case adminVerify = "admin_verify"
        case storeInformation = "store_information"
        case bankInformation = "bank_information"
        case rejectReason = "reject_reason"
        case lang
        case isBlock = "is_block"
        case affilateCommission = "affilate_commission"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case storeInfo = "store_info"
    }
}

enum SellerDetailsCreatedAt: String, Codable {
    case the20251105T100934000000Z = "2025-11-05T10:09:34.000000Z"
    case the20251112T061232000000Z = "2025-11-12T06:12:32.000000Z"
    case the20251125T105953000000Z = "2025-11-25T10:59:53.000000Z"
}

enum Email: String, Codable {
    case bdr8080GmailCOM = "bdr8080@gmail.com"
    case storeGmailCOM = "Store@gmail.com"
    case testingGmailCOM = "Testing@gmail.com"
}

enum FirstName: String, Codable {
    case john = "John"
    case salimS = "Salim s"
    case sourabh = "Sourabh"
}

enum LastName: String, Codable {
    case bdr = "Bdr"
    case john = "John"
    case shop = "shop"
}

enum Password: String, Codable {
    case the2Y12JvyiZTvxOYa6CqBmHlXQDJHPSeqwuzt4V0MFa4AN5IEoTedRoZy = "$2y$12$JvyiZTvxOYa6cqBmHlXQD.JHpSeqwuzt4V0MFa4AN5iEo/tedRoZy"
    case the2Y12NFq5BPp5DybwyBDWcOZKFeclvUEaR11WS8JTVPHaScnCm59OeY2Ue = "$2y$12$NFq5bPp5dybwyBDWcOZKFeclvUEaR11wS8jTVPHaScnCm59OeY2Ue"
    case the2Y12UPmnc2Lmqr3UwxI0GIOPROU5DPsrIx5IMQ3CTJoFrtUnPFeiEcm = "$2y$12$uPmnc2Lmqr3uwxI0GIOPrOU5D.psrIx5imQ3Ct/joFrtUnPFeiEcm"
}

// MARK: - StoreInfo
struct StoreInfo: Codable {
    var id, sellerID: Int?
    var storeImage: String?
    var storeName: String?
    var country: String?
    var storeAddress: String?
    var addressLine1: String?
    var addressLine2: String?
    var storePhone, countryCode: String?
    var storeMailID: String?
    var storeAvailability: Int?
    var bio: String?
    var storeInfoLet, long: String?
    var createdAt: String?
    var updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case sellerID = "seller_id"
        case storeImage = "store_image"
        case storeName = "store_name"
        case country
        case storeAddress = "store_address"
        case addressLine1 = "address_line1"
        case addressLine2 = "address_line2"
        case storePhone = "store_phone"
        case countryCode = "country_code"
        case storeMailID = "store_mail_id"
        case storeAvailability = "Store_Availability"
        case bio
        case storeInfoLet = "let"
        case long
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}



// MARK: - VariationDetails
struct VariationDetails: Codable {
    var id, productID: Int?
    var parentChild: String?
    var variantImage: [String]?
    var colorID, sizeID: String?
    var bust, waist, hip, shoulder: String?
    var sleeveLength, length: String?
    var totalStock, sku: String?
    var skuThresholdValue: String?
    var actualPrice, discountType, discountValue, finalPrice: String?
    var status, createdAt, updatedAt: String?
    var color, size: Color?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case parentChild = "parent_child"
        case variantImage = "variant_image"
        case colorID = "color_id"
        case sizeID = "size_id"
        case bust, waist, hip, shoulder
        case sleeveLength = "sleeve_length"
        case length
        case totalStock = "total_stock"
        case sku
        case skuThresholdValue = "sku_threshold_value"
        case actualPrice = "actual_price"
        case discountType = "discount_type"
        case discountValue = "discount_value"
        case finalPrice = "final_price"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case color, size
    }
}

// MARK: - Color
struct Color: Codable {
    var id: Int?
    var name, hexCode: String?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case hexCode = "hex_code"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


// MARK: - Link
struct Link: Codable {
    var url: String?
    var label: String?
    var active: Bool?
}

// MARK: - DeliveryList
//struct DeliveryList: Codable {
//    var id: Int?
//    var orderID: String?
//    var userID, deliveryAddress: Int?
//    var totalMrp, discountMrp, promocodeStatus, promocodeID: String?
//    var promocodeValue, giftcardAmount, giftcardID, shippingFees: String?
//    var tax, walletAmount, totalAmount, paymentStatus: String?
//    var paymentMethod, deliveryStatus, transactionID, deliveryBoyID: String?
//    var assignStatus, assignDate, notDeliveredReason, createdAt: String?
//    var updatedAt: String?
//    var distance: Int?
//    var deliveryDetails: DeliveryDetails?
//    var orderDetails: [OrderDetail]?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case orderID = "order_id"
//        case userID = "user_id"
//        case deliveryAddress = "delivery_address"
//        case totalMrp = "total_mrp"
//        case discountMrp = "discount_mrp"
//        case promocodeStatus = "promocode_status"
//        case promocodeID = "promocode_id"
//        case promocodeValue = "promocode_value"
//        case giftcardAmount = "giftcard_amount"
//        case giftcardID = "giftcard_id"
//        case shippingFees = "shipping_fees"
//        case tax
//        case walletAmount = "wallet_amount"
//        case totalAmount = "total_amount"
//        case paymentStatus = "payment_status"
//        case paymentMethod = "payment_method"
//        case deliveryStatus = "delivery_status"
//        case transactionID = "transaction_id"
//        case deliveryBoyID = "delivery_boy_id"
//        case assignStatus = "assign_status"
//        case assignDate = "assign_date"
//        case notDeliveredReason = "not_delivered_reason"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case distance
//        case deliveryDetails = "delivery_details"
//        case orderDetails = "order_details"
//    }
//}
//
//// MARK: - DeliveryDetails
//struct DeliveryDetails: Codable {
//    var id, userID: Int?
//    var name, mobile, countryCode, address: String?
//    var houseNo, streetNo, postalCode, city: String?
//    var state, countryName, landmark: String?
//    var saveAddressAs, status: Int?
//    var latitude, longitude, createdAt, updatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case userID = "user_id"
//        case name, mobile
//        case countryCode = "country_code"
//        case address
//        case houseNo = "house_no"
//        case streetNo = "street_no"
//        case postalCode = "postal_code"
//        case city, state
//        case countryName = "country_name"
//        case landmark
//        case saveAddressAs = "save_address_as"
//        case status, latitude, longitude
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}
//
//// MARK: - OrderDetail
//struct OrderDetail: Codable {
//    var id, orderID, userID, productID: Int?
//    var variantsID, quantity: Int?
//    var amount, status, createdAt, updatedAt: String?
//    var returnType, rEApprove, returnReason, returnImage: String?
//    var exchangeReason, exchangeNewSize, exchangeOldSize, paymentStatus: String?
//    var deliveryStatus, deliveryBoyID, assignStatus, assignDate: String?
//    var productDetails: ProductDetails?
//    var variationDetails: VariationDetails?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case orderID = "order_id"
//        case userID = "user_id"
//        case productID = "product_id"
//        case variantsID = "variants_id"
//        case quantity, amount, status
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case returnType = "return_type"
//        case rEApprove = "r_e_approve"
//        case returnReason = "return_reason"
//        case returnImage = "return_image"
//        case exchangeReason = "exchange_reason"
//        case exchangeNewSize = "exchange_new_size"
//        case exchangeOldSize = "exchange_old_size"
//        case paymentStatus = "payment_status"
//        case deliveryStatus = "delivery_status"
//        case deliveryBoyID = "delivery_boy_id"
//        case assignStatus = "assign_status"
//        case assignDate = "assign_date"
//        case productDetails = "product_details"
//        case variationDetails = "variation_details"
//    }
//}
//
//// MARK: - ProductDetails
//struct ProductDetails: Codable {
//    var id: Int?
//    var sellerID, storeID, categoryID, subcategoryID: String?
//    var brandID, otherEn, otherAr, productNameEn: String?
//    var productNameAr, descriptionEn, descriptionAr, minCardQuantity: String?
//    var maxCardQuantity, productReturn, returnDays, productExchangable: String?
//    var exchangableDays, reviewRating, affiliatedProduct, affiliatedCommission: String?
//    var customizedProduct, readyToShip, cashOnDelivery: String?
//    var uploadSizeChart: String?
//    var productActiveStatus: Int?
//    var createdAt, updatedAt: String?
//    var sellerDetails: SellerDetails?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case sellerID = "seller_id"
//        case storeID = "store_id"
//        case categoryID = "category_id"
//        case subcategoryID = "subcategory_id"
//        case brandID = "brand_id"
//        case otherEn = "other_en"
//        case otherAr = "other_ar"
//        case productNameEn = "product_name_en"
//        case productNameAr = "product_name_ar"
//        case descriptionEn = "description_en"
//        case descriptionAr = "description_ar"
//        case minCardQuantity = "min_card_quantity"
//        case maxCardQuantity = "max_card_quantity"
//        case productReturn = "product_return"
//        case returnDays = "return_days"
//        case productExchangable = "product_exchangable"
//        case exchangableDays = "exchangable_days"
//        case reviewRating = "review_rating"
//        case affiliatedProduct = "affiliated_product"
//        case affiliatedCommission = "affiliated_commission"
//        case customizedProduct = "customized_product"
//        case readyToShip = "ready_to_ship"
//        case cashOnDelivery = "cash_on_delivery"
//        case uploadSizeChart = "upload_size_chart"
//        case productActiveStatus = "product_active_status"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case sellerDetails = "seller_details"
//    }
//}
//
//// MARK: - SellerDetails
//struct SellerDetails: Codable {
//    var id: Int?
//    var profilePic: String?
//    var firstName, lastName, countryCode, mobile: String?
//    var email, password, acceptTerms, otp: String?
//    var otpVerify, deviceType, deviceToken, adminVerify: String?
//    var storeInformation, bankInformation, rejectReason, lang: String?
//    var isBlock: Int?
//    var affilateCommission, createdAt, updatedAt: String?
//    var storeInfo: StoreInfo?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case profilePic = "profile_pic"
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case countryCode = "country_code"
//        case mobile, email, password
//        case acceptTerms = "accept_terms"
//        case otp
//        case otpVerify = "otp_verify"
//        case deviceType = "device_type"
//        case deviceToken = "device_token"
//        case adminVerify = "admin_verify"
//        case storeInformation = "store_information"
//        case bankInformation = "bank_information"
//        case rejectReason = "reject_reason"
//        case lang
//        case isBlock = "is_block"
//        case affilateCommission = "affilate_commission"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case storeInfo = "store_info"
//    }
//}
//
//// MARK: - StoreInfo
//struct StoreInfo: Codable {
//    var id, sellerID: Int?
//    var storeImage: String?
//    var storeName, country, storeAddress, addressLine1: String?
//    var addressLine2, storePhone, countryCode, storeMailID: String?
//    var storeAvailability: Int?
//    var bio, storeInfoLet, long, createdAt: String?
//    var updatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case sellerID = "seller_id"
//        case storeImage = "store_image"
//        case storeName = "store_name"
//        case country
//        case storeAddress = "store_address"
//        case addressLine1 = "address_line1"
//        case addressLine2 = "address_line2"
//        case storePhone = "store_phone"
//        case countryCode = "country_code"
//        case storeMailID = "store_mail_id"
//        case storeAvailability = "Store_Availability"
//        case bio
//        case storeInfoLet = "let"
//        case long
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}
//
//// MARK: - Link
//struct Link: Codable {
//    var url: String?
//    var label: String?
//    var active: Bool?
//}
//
//
// MARK: - ReasonListModel
struct ReasonListModel: Codable {
    var id: Int?
    var reasonEnglish, reasonArabic: String?
    var type, status: Int?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case reasonEnglish = "reason_english"
        case reasonArabic = "reason_arabic"
        case type, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
//
//// MARK: - VariationDetails
//struct VariationDetails: Codable {
//    var id, productID: Int?
//    var parentChild: String?
//    var variantImage: [String]?
//    var colorID, sizeID, bust, waist: String?
//    var hip, shoulder, sleeveLength, length: String?
//    var totalStock, sku: String?
//    var skuThresholdValue: String?
//    var actualPrice, discountType, discountValue, finalPrice: String?
//    var status, createdAt, updatedAt: String?
//    var color, size: Color?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case productID = "product_id"
//        case parentChild = "parent_child"
//        case variantImage = "variant_image"
//        case colorID = "color_id"
//        case sizeID = "size_id"
//        case bust, waist, hip, shoulder
//        case sleeveLength = "sleeve_length"
//        case length
//        case totalStock = "total_stock"
//        case sku
//        case skuThresholdValue = "sku_threshold_value"
//        case actualPrice = "actual_price"
//        case discountType = "discount_type"
//        case discountValue = "discount_value"
//        case finalPrice = "final_price"
//        case status
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case color, size
//    }
//}
//
//// MARK: - Color
//struct Color: Codable {
//    var id: Int?
//    var name, hexCode, createdAt, updatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case hexCode = "hex_code"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}
