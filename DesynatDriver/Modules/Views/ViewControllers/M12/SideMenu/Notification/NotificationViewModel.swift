//
//  NotificationViewModel.swift
//  DesynatDriver
//
//  Created by fluper_mac3 on 17/04/26.
//

import Foundation

class NotificationViewModel {
    
    private var hostVC: NotificationViewController
    
    init(hostVC: NotificationViewController) {
        self.hostVC = hostVC
    }
    
    func updatePushNotificationSettingRequest() {
        WebService.sharedInstance.updatePushNotificationSettingService() { [weak self] response in
            guard let self = self else { return }
            self.hostVC.isPushNotification = (response.notification == 0) ? false : true
            self.hostVC.updatePushNotificationUI()
        }
    }
    
    func updateAppNotificationSettingRequest() {
        WebService.sharedInstance.updateAppNotificationSettingService() { [weak self] response in
            guard let self = self else { return }
            self.hostVC.isAppNotification = (response.appNotification == 0) ? false : true
            self.hostVC.updateAppNotificationUI()
        }
    }
    
    func getProfile() {
        WebService.sharedInstance.getProfile { [weak self] response in
            guard let self = self else { return }
            driverProfileData = response
            DispatchQueue.main.async {
                self.hostVC.isPushNotification = (response.notification == 0) ? false : true
                self.hostVC.isAppNotification = (response.appNotification == 0) ? false : true
                self.hostVC.updatePushNotificationUI()
                self.hostVC.updateAppNotificationUI()
            }
        }
    }
    
    func deleteAccountRequest(){
        WebService.sharedInstance.deleteAccountService() { (response) in
            kSharedSceneDelegate.logoutUser()
            kSharedSceneDelegate.navigateToLoginVC()
        }
    }
    
}
