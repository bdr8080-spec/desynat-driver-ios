import Foundation

let kisOnBoardingChecked = "isOnBoardingChecked"

enum BaseURL {
    static let development  = "http://157.241.119.72"
    static let release      = "http://157.241.119.72"
    
    
    static func value() -> String {
        switch BuildConfiguration.shared.environment {
        case .debug:
            return BaseURL.development
        case .release:
            return BaseURL.release
        }
    }
}

enum NetworkEndPoint: String {
    
    case register                     = "user-registration/basic-registration"
    case login                        = "/api/deliveryboy/login"
    case country                      = "/api/country"
    case forgotPassword               = "/api/deliveryboy/forgot_password"
    case verifyOtp                    = "/api/deliveryboy/verify_otp"
    case resendOtp                    = "/api/deliveryboy/resend_otp"
    case createPassword               = "/api/deliveryboy/create_password"
    case logout                       = "/api/deliveryboy/logout"
    
    
    // M2
    case dutyOnOff                      = "/api/deliveryboy/duty_on_off"
    case getProfile                     = "/api/deliveryboy/get_profile_details"
    case uploadImage                    = "/api/upload"
    case getZoneListOfDriver          = "/api/admin/get_kuwait_zones"
    case editDriverDetails          = "/api/deliveryboy/update_profile"
    
    //M5
    case getAllOrders = "/api/deliveryboy/get_all_orders"
    case getNewOrders = "/api/deliveryboy/get_new_orders"
    case getOngoingOrders = "/api/deliveryboy/get_ongoing_orders"
    case orderDetails = "/api/deliveryboy/order_details"
    case updateDeliveryStatus = "/api/deliveryboy/update_delivery_status"
    case pickOrder = "/api/deliveryboy/pick_order"
    case getCompletedOrder = "/api/deliveryboy/get_completed_orders"
    case getReasons = "/api/deliveryboy/get_reasons"
    
    func withBaseURL() -> String {
        return "\(BaseURL.value())\(self.rawValue)"
    }
}

enum NetworkURL {
    case endpoint(NetworkEndPoint)
    case custom(String)
}

