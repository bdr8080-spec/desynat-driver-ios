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
    @IBOutlet weak var btnDelete: CustomButton!
    
    private lazy var viewModel = NotificationViewModel(hostVC: self)
    var isAppNotification = false
    var isPushNotification = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnDelete.setTitle("Delete Account".localiz(), for: .normal)
        viewModel.getProfile()
    }
    
    // MARK: - Actions
    @IBAction func appnotificationbtn(_ sender: UIButton) {
        viewModel.updateAppNotificationSettingRequest()
    }
    
    @IBAction func pushnotification(_ sender: UIButton) {
        viewModel.updatePushNotificationSettingRequest()
    }
    
    @IBAction func deleteAccountDidTapped(_ sender: Any) {
        let nextVC = DeleteAccountViewController.instantiate(fromAppStoryboard: .SideMenu)
        nextVC.onYesTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.deleteAccountRequest()
        }
        self.navigationController?.present(nextVC, animated: true)
    }
    
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
}

