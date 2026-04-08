//
//  SettingViewController.swift
//  DesynatDriver
//
//  Created by Akshara Tomar  on 07/04/26.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func changePasswordDidTapped(_ sender: Any) {
        let vc = ChangePassowrdViewController.instantiate(fromAppStoryboard: .SideMenu)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func notificationDidTapped(_ sender: Any) {
        let vc = NotificationViewController.instantiate(fromAppStoryboard: .SideMenu)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func backBtnDidTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
