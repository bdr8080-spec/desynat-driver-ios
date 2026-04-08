//
//  NotificationViewController.swift
//  DesynatDriver
//
//  Created by Akshara Tomar  on 07/04/26.
//

import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var pushnotification: UIButton!
    @IBOutlet weak var appnotificationbtn: UIButton!
    
    var isAppNotification = false
    var isPushNotification = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appnotificationbtn.adjustsImageWhenHighlighted = false
        pushnotification.adjustsImageWhenHighlighted = false
        updateAppNotificationUI()
        updatePushNotificationUI()
    }
    
    // MARK: - Actions
    @IBAction func appnotificationbtn(_ sender: UIButton) {
        isAppNotification.toggle()
        updateAppNotificationUI()
    }
    @IBAction func pushnotification(_ sender: UIButton) {
        isPushNotification.toggle()
        updatePushNotificationUI()
    }
    @IBAction func deleteAccountDidTapped(_ sender: Any) {
        let nextVC = DeleteAccountViewController.instantiate(fromAppStoryboard: .SideMenu)
        nextVC.onYesTapped = { [weak self] in
            guard let self = self else { return }
            self.deleteAccountRequest()
        }
        self.navigationController?.present(nextVC, animated: true)
    }
    func deleteAccountRequest(){
        //        WebService.sharedInstance.logoutService() { (response) in
        //            kSharedSceneDelegate.logoutUser()
        //            kSharedSceneDelegate.navigateToLoginVc()
        //            UserDefaults.standard.setValue("No", forKey:"isLogin")
        //        }
    }
    
    // MARK: - UI Update
    func updateAppNotificationUI() {
        let imageName = isAppNotification ? "toggle" : "toggle_off"
        appnotificationbtn.setImage(UIImage(named: imageName), for: .normal)
    }
    
    func updatePushNotificationUI() {
        let imageName = isPushNotification ? "toggle" : "toggle_off"
        pushnotification.setImage(UIImage(named: imageName), for: .normal)
    }
    
    @IBAction func backbtn(_ sender: Any) {
       
        self.navigationController?.popViewController(animated: true)
    }
}

