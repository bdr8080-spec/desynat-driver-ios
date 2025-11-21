//
//  ProfileVC.swift
//  DesynatDriver
//
//  Created by Mohd Faizan on 20/11/25.
//

import UIKit

class ProfileVC: UIViewController {
    private lazy var viewModel = ProfileVM(hostVC:self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnTapLogout(_ sender: UIButton) {
        viewModel.logoutApi()
    }
}
