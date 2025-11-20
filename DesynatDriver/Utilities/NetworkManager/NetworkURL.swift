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
    
    
    func withBaseURL() -> String {
        return "\(BaseURL.value())\(self.rawValue)"
    }
}

enum NetworkURL {
    case endpoint(NetworkEndPoint)
    case custom(String)
}

