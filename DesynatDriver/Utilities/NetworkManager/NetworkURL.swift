import Foundation

let kisOnBoardingChecked = "isOnBoardingChecked"

enum BaseURL {
    static let development  = "https://desynat.com"//"http://157.241.119.72"
    static let release      = "https://desynat.com"//http://157.241.119.72"
    
    
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
    
    case register                        = "user-registration/basic-registration"
    case login                           = "/api/deliveryboy/login"
    case country                         = "/api/country"
    case forgotPassword                  = "/api/deliveryboy/forgot_password"
    case verifyOtp                       = "/api/deliveryboy/verify_otp"
    case resendOtp                       = "/api/deliveryboy/resend_otp"
    case createPassword                  = "/api/deliveryboy/create_password"
    case logout                          = "/api/deliveryboy/logout"
    
    
    // M2
    case dutyOnOff                        = "/api/deliveryboy/duty_on_off"
    case getProfile                       = "/api/deliveryboy/get_profile_details"
    case uploadImage                      = "/api/upload"
    case getZoneListOfDriver              = "/api/admin/get_kuwait_zones"
    case editDriverDetails                = "/api/deliveryboy/update_profile"
    
    //M5
    case getAllOrders                     = "/api/deliveryboy/get_all_orders"
    case getNewOrders                     = "/api/deliveryboy/get_new_orders"
    case getOngoingOrders                 = "/api/deliveryboy/get_ongoing_orders"
    case orderDetails                     = "/api/deliveryboy/order_details"
    case updateDeliveryStatus             = "/api/deliveryboy/update_delivery_status"
    case returnOrderToStoreInExchangeDeliveryStatus = "/api/deliveryboy/return-order-to-store-in-exchange"
    case pickOrder                         = "/api/deliveryboy/pick_order"
    case getCompletedOrder                 = "/api/deliveryboy/get_completed_orders"
    case getReasons                        = "/api/deliveryboy/get_reasons"
    
    //M10
    case getMyNotificationsList            = "/api/deliveryboy/get_notifications_list"
    case markReadNotifications             = "/api/deliveryboy/mark_notification_as_read"
    case markAllReadNotifications          = "/api/deliveryboy/driver_mark_all_notification_as_read"
    case countOfNotifcationForAffilated    = "/api/deliveryboy/get_notifications_count"
    
    
    //M11
    case raiseTicket                        = "/api/deliveryboy/raise_ticket"
    case getRaiseTicket                     = "/api/deliveryboy/get_raised_tickets"
    case getTicketsType                     = "/api/ticket_types"
    
    //M13
    case contactUs                          = "/api/contact_us"
    case returnPolicy                       = "/api/return_policy"
    case termsAndConditions                 = "/api/terms_conditions"
    case aboutUs                            = "/api/about_us"
    case cancellationPolicy                 = "/api/cancellation_policy"
    case exchangePolicy                     = "/api/exchange_policy"
    case faqList                            = "/api/faqs"
    case pushNotificationOnOff              = "/api/deliveryboy/notification_on_off"
    case appNotificationOnOff               = "/api/deliveryboy/app_notification_on_off"
    
    func withBaseURL() -> String {
        return "\(BaseURL.value())\(self.rawValue)"
    }
}

enum NetworkURL {
    case endpoint(NetworkEndPoint)
    case custom(String)
}

