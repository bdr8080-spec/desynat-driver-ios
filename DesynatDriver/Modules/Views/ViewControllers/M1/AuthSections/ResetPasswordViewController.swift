//
//  ResetPasswordViewController.swift
//  DesynatUser
//
//  Created by Rakhi Kumari on 23/10/25.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    private lazy var viewModel = ResetPasswordViewModel(hostVC:self)
    @IBOutlet weak var txtCreatePass: UITextField!
    @IBOutlet weak var txtConfirmPass: UITextField!
    var userId:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func doneDidTapped(_ sender: Any) {
        if txtCreatePass.text == ""{
            showToast(msg:"Please enter create password")
        }else if txtConfirmPass.text == ""{
            showToast(msg:"Please enter confirm password")
        }else{
            viewModel.createPasswordApi()
        }
    }
    
    @IBAction func backDidTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
