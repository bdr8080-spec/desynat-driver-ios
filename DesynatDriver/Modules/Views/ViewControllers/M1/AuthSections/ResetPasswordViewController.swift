//
//  ResetPasswordViewController.swift
//  DesynatUser
//
//  Created by Rakhi Kumari on 23/10/25.
//

import UIKit

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtCreatePass: UITextField!
    @IBOutlet weak var txtConfirmPass: UITextField!
    
    private lazy var viewModel = ResetPasswordViewModel(hostVC:self)
    var userId:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCreatePass.delegate = self
        txtConfirmPass.delegate = self
    }
    
    @IBAction func doneDidTapped(_ sender: Any) {
        let createPass = txtCreatePass.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let confirmPass = txtConfirmPass.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        // Empty field checks
        if createPass.isEmpty {
            showAlert(msg:"Please enter create password".localiz())
            return
        }else if !createPass.isValidPassword() {
            showAlert(msg:"Password must be at least 8 characters long and contain letters and numbers".localiz())
            return
        }else if confirmPass.isEmpty {
            showAlert(msg:"Please enter confirm password".localiz())
            return
        }else if confirmPass != createPass {
            showAlert(msg:"Password does not match".localiz())
            return
        } else {
            viewModel.createPasswordApi()
        }
        
    }
    
    @IBAction func backDidTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTapCreatePasswordEye(_ sender: UIButton) {
        sender.isSelected.toggle()
        txtCreatePass.isSecureTextEntry.toggle()
    }
    
    @IBAction func btnTapConfirmPasswordEye(_ sender: UIButton) {
        sender.isSelected.toggle()
        txtConfirmPass.isSecureTextEntry.toggle()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // ❌ Block space character
        if string == " " { return false }
        
        return true
    }
    
}
