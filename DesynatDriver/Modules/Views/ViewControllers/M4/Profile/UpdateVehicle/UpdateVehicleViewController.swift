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
  
  override func viewDidLoad() {
        super.viewDidLoad()
    setupUI()
    }
    
  @IBAction func crossDidTapped(_ sender: Any) {
    self.dismiss(animated: true)
  }
  
  @IBAction func updateDidTapped(_ sender: Any) {
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
  
  func setupUI() {
    headerView.layer.cornerRadius = 32
    headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    headerView.clipsToBounds = true
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

enum ComingReasonAtUpdateVehicle {
  case vehicleName
  case updateVehicleRegistration
}
