//
//  AppDelegate.swift
//  DemoProject
//
//  Created by Rakhi Kumari on 22/09/25.
//

import UIKit
import GoogleMaps
import GooglePlaces
import DropDown
import IQKeyboardManagerSwift
import UserNotifications
import FirebaseCore
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
    
    var forOpenFilePickerView = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 2.5)
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.isEnabled = true
        LocationManager.sharedInstance.startUpdatingLocation()
        GMSServices.provideAPIKey("AIzaSyBlCfJlRuxElolt6l-4erdJPR9ySUB8Jwk")
        GMSPlacesClient.provideAPIKey("AIzaSyAekJV3oxQlPy_OWHCxPYfFw5CnrD-Wzkg")
        UNUserNotificationCenter.current().delegate = self
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true
        confrigNotification(application: application)
        UNUserNotificationCenter.current().setBadgeCount(0, withCompletionHandler: nil)
//        TidioSDK.initialize(
//            projectId: "YOUR_PROJECT_ID",
//            apiKey: "na5y0weklpcd9uxhccfezplsfg0fggvk"
//        )
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
    
    func dropDown(dataSource:[String] , anchorView:UIView , completion: @escaping (  _ index: Int ,  _ item: String) -> ()) -> Void {
        let dropDown = DropDown()
        dropDown.anchorView = anchorView
        dropDown.dataSource = dataSource
        dropDown.backgroundColor = UIColor.white
        dropDown.textColor = .black
        dropDown.direction = .bottom
        dropDown.selectionBackgroundColor = UIColor.white
        dropDown.selectedTextColor = .black
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.dismissMode = .automatic
        dropDown.show()
        dropDown.selectionAction = {(index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            completion(index,item)
            
        }
    }
    
}

extension AppDelegate:UNUserNotificationCenterDelegate {
    
    func confrigNotification(application:UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
            guard granted else { return }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()  // only once
            }
        }
    }
    
    private func registerForPushNotification(_ application: UIApplication) {
        let current = UNUserNotificationCenter.current()
        current.delegate = self
        current.requestAuthorization(options: [.alert, .badge, .sound]) { (flag, error) in
            if error == nil {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        Messaging.messaging().setAPNSToken(deviceToken,type: .unknown)
        fetchFirebaseToken()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        kSharedUserDefaults.saveValue(Key: .deviceToken, value: fcmToken)
    }
    
    fileprivate func fetchFirebaseToken() {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = token {
                print("Remote instance ID token: \(result)")
                kSharedUserDefaults.saveModelFor(key: .deviceToken, value: token)
            }
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let payload = notification.request.content.userInfo
        
        // Convert payload to JSON text
        if let jsonText = payload.toPrettyString() {
            
            //            showShareAlert(withText: jsonText)
        }
        let badge = notification.request.content.badge?.intValue ?? 0
        
        UNUserNotificationCenter.current().setBadgeCount(badge, withCompletionHandler: nil)
        if #available(iOS 14.0, *) {
            completionHandler([.banner, .badge, .sound])
        } else {
            completionHandler([.alert, .badge, .sound])
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("")
    }
    
    func topViewController(base: UIViewController? = UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .flatMap { $0.windows }
        .first { $0.isKeyWindow }?
        .rootViewController) -> UIViewController? {
            
            if let nav = base as? UINavigationController {
                return topViewController(base: nav.visibleViewController)
            }
            if let tab = base as? UITabBarController {
                return topViewController(base: tab.selectedViewController)
            }
            if let presented = base?.presentedViewController {
                return topViewController(base: presented)
            }
            return base
        }
    
    func showShareAlert(withText text: String) {
        guard let topVC = topViewController() else { return }
        let alert = UIAlertController(title: "Debug / Share", message: text, preferredStyle: .alert)
        let shareAction = UIAlertAction(title: "Share", style: .default) { _ in
            let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = topVC.view // for iPad
            topVC.present(activityVC, animated: true, completion: nil)
        }
        let copyAction = UIAlertAction(title: "Copy", style: .default) { _ in
            UIPasteboard.general.string = text
        }
        let cancelAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alert.addAction(shareAction)
        alert.addAction(copyAction)
        alert.addAction(cancelAction)
        topVC.present(alert, animated: true, completion: nil)
    }
    
}

extension Dictionary {
    func toPrettyString() -> String? {
        if JSONSerialization.isValidJSONObject(self),
           let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
           let text = String(data: data, encoding: .utf8) {
            return text
        }
        return nil
    }
}
