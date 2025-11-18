//
//  LoginViewController.swift
//  DesynatUser
//
//  Created by Rakhi Kumari on 23/10/25.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func loginDidTapped(_ sender: Any) {
       // let vc = HomeViewController.instantiate(fromAppStoryboard: .Home)
        let vc = TabBarVC.instantiate(fromAppStoryboard:.Home)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func forgotPasswordDidTapped(_ sender: Any) {
        let vc = ForgotPasswordViewController.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
