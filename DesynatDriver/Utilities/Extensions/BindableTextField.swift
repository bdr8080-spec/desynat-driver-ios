//
//  BindableTextField.swift
//  DesynatDriver
//
//  Created by Chandra Prakash on 24/12/25.
//

import Foundation
import UIKit

class BindableTextField: CustomTextfieldFont {
    
    var currentText: (String) -> () = { _ in }
    
    func bind(callback: @escaping (String) -> ()) {
        self.currentText = callback
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.currentText(String.getString(textField.text))
    }
}
