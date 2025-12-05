//
//  UpdateVehicleViewController.swift
//  DesynatDriver
//
//  Created by fluper on 04/12/25.
//

import UIKit

class UpdateVehicleViewController: UIViewController {
  
  @IBOutlet weak var titleTF: UITextField!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var headerView: UIView!
  
  var comingReason: ComingReasonAtUpdateVehicle = .vehicleName
  var vehicleInfo: String? = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  @IBAction func crossDidTapped(_ sender: Any) {
    self.dismiss(animated: true)
  }
  
  @IBAction func updateDidTapped(_ sender: Any) {
    if validateFields() {
      editDriverProfileApi()
    }
  }
  
  func setupUI() {
    titleTF.delegate = self
    headerView.layer.cornerRadius = 32
    headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    headerView.clipsToBounds = true
    titleTF.text = vehicleInfo ?? ""
    switch comingReason {
    case .vehicleName:
      titleLabel.text = "Update Vehicle Name"
      titleTF.placeholder = "Enter Vehicle Name"
    case .updateVehicleRegistration:
      titleLabel.text = "Update Vehicle Registration No ."
      titleTF.placeholder = "Enter Vehicle Registration No ."
    }
  }
  
}

extension UpdateVehicleViewController {
  
  func editDriverProfileApi() {
    let details =  String.getString(titleTF.text)
    var params: [String: Any] = ["delivery_boy_id":  driverProfileData?.id ?? 0]
    switch comingReason {
    case .vehicleName:
      params["vehicle_name"] = details
    case .updateVehicleRegistration:
      params["vehicle_reg_no"] = details
    }
    WebService.sharedInstance.editDriverDetails(param: params) { (response) in
      DispatchQueue.main.async { [weak self] in
        guard let self else { return }
        let nextVC = UpdateSuccessViewController.instantiate(fromAppStoryboard: .Profile)
        switch comingReason {
        case .vehicleName:
          nextVC.comingReason = .vehicleName
        case .updateVehicleRegistration:
          nextVC.comingReason = .updateVehicleRegistration
        }
        nextVC.callBackDismiss = {
          self.dismiss(animated: true)
        }
        self.present(nextVC, animated: true)
      }
    }
  }
  
  func validateFields() -> Bool {
    var error: AlertConstant = .none
    if titleTF.text?.isEmpty ?? true {
      switch comingReason {
      case .vehicleName:
        error = .enterVehicleName
      case .updateVehicleRegistration:
        error = .enterVehicleReg
      }
    }
    if error != .none {
      showAlert(msg: error.rawValue)
      return false
    }
    return true
  }
  
}

extension UpdateVehicleViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    let currentText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    if string.isEmpty { return true }
    if currentText.hasPrefix(" ") { return false }
    let fieldsAllowingSpaces: [UITextField] = [titleTF]
    if !fieldsAllowingSpaces.contains(textField) {
      if string.contains(" ") {
        return false
      }
    }
    var validation: StringValidation?
    if let data = validation {
      return data.validate()
    } else {
      return true
    }
  }
}

enum ComingReasonAtUpdateVehicle {
  case vehicleName
  case updateVehicleRegistration
}
