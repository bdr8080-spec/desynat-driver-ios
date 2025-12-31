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
  let userRatingReviewProvide: UserRatingReviewProvide?
  
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
    case userRatingReviewProvide = "user_rating_review_provide"
  }
}

// MARK: - UserRatingReviewProvide
struct UserRatingReviewProvide: Codable {
  let id, userID, orderID, orderdetailsID: Int?
  let productID: Int?
  let productRating, productReview, productImage: String?
  let storeID: Int?
  let storeRating, storeReview, storeImage, createdAt: String?
  let updatedAt: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case userID = "user_id"
    case orderID = "order_id"
    case orderdetailsID = "orderdetails_id"
    case productID = "product_id"
    case productRating = "product_rating"
    case productReview = "product_review"
    case productImage = "product_image"
    case storeID = "store_id"
    case storeRating = "store_rating"
    case storeReview = "store_review"
    case storeImage = "store_image"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
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
  let userDetails: UserDetails?
  
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
    case userDetails = "user_details"
  }
}

// MARK: - UserDetails
struct UserDetails: Codable {
    let id: Int?
    let profileImage: String?
    let fullName, countryCode, mobile, email: String?
    let emailVerifiedAt: String?
    let otp, otpVerify, deviceType: String?
    let deviceToken, userDetailsLet, long: String?
    let status, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case profileImage = "profile_image"
        case fullName = "full_name"
        case countryCode = "country_code"
        case mobile, email
        case emailVerifiedAt = "email_verified_at"
        case otp
        case otpVerify = "otp_verify"
        case deviceType = "device_type"
        case deviceToken = "device_token"
        case userDetailsLet = "let"
        case long, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - DeliveryDetails
struct DeliveryDetails: Codable {
  var id, userID: Int?
  var name: String?
  var mobile, countryCode, profilePic: String?
  var address: String?
  var houseNo: String?
  var streetNo: String?
  var postalCode: String?
  var city: String?
  var state: String?
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
    case profilePic = "profile_Pic"
  }
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
