//
//  SettingViewController.swift
//  DesynatDriver
//
//  Created by Akshara Tomar  on 07/04/26.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var ivChngPass: UIImageView!
    @IBOutlet weak var btnDeleteAccount: CustomButton!
    @IBOutlet weak var ivNotifi: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnDeleteAccount.setTitle("Delete Account".localiz(), for: .normal)
        if AppLanguageManager.shared.isRightToLeft {
            self.ivChngPass.semanticContentAttribute = .forceRightToLeft
            self.ivChngPass?.transform = CGAffineTransform(scaleX: -1, y: 1)
            self.ivNotifi.semanticContentAttribute = .forceRightToLeft
            self.ivNotifi?.transform = CGAffineTransform(scaleX: -1, y: 1)
        } else {
            self.ivChngPass.semanticContentAttribute = .forceLeftToRight
            self.ivChngPass?.transform = .identity
            self.ivNotifi.semanticContentAttribute = .forceLeftToRight
            self.ivNotifi?.transform = .identity
        }
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
