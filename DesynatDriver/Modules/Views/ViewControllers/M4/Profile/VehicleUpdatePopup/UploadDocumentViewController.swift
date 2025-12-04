//
//  UploadDocumentViewController.swift
//  DesynatDriver
//
//  Created by fluper on 04/12/25.
//

import UIKit

class UploadDocumentViewController: UIViewController {
  
  @IBOutlet weak var headerView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var backView: UIView!
  @IBOutlet weak var frontView: UIView!
  
  var comingReason: ComingReasonUploadDocument = .vehicleImage
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initialSetup()
  }
  
  @IBAction func crossDidTapped(_ sender: Any) {
    self.dismiss(animated: true)
  }
  
  @IBAction func updateDidTapped(_ sender: Any) {
    let nextVC = UpdateSuccessViewController.instantiate(fromAppStoryboard: .Profile)
    switch comingReason {
    case .vehicleImage:
      nextVC.comingReason = .vehicleImage
    case .identityProof:
      nextVC.comingReason = .identityProof
    case .drivingLicence:
      nextVC.comingReason = .drivingLicence
    case .vehcileInsurance:
      nextVC.comingReason = .vehcileInsurance
    case .pollutionPaper:
      nextVC.comingReason = .pollutionPaper
    case .registrationCertificate:
      nextVC.comingReason = .registrationCertificate
    }
    nextVC.callBackDismiss = {
      self.dismiss(animated: true)
    }
    self.present(nextVC, animated: true)
  }
  
  func initialSetup() {
    headerView.layer.cornerRadius = 32
    headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    headerView.clipsToBounds = true
    switch comingReason {
    case .vehicleImage:
      titleLabel.text = "Vehicle Images"
    case .identityProof:
      titleLabel.text = "Identity proof"
    case .drivingLicence:
      titleLabel.text = "Driving license"
    case .vehcileInsurance:
      titleLabel.text = "Vehicle insurance"
    case .pollutionPaper:
      titleLabel.text = "Pollution paper"
    case .registrationCertificate:
      titleLabel.text = "Registration Certificate"
    }
  }
}

enum ComingReasonUploadDocument {
  case vehicleImage
  case identityProof
  case drivingLicence
  case vehcileInsurance
  case pollutionPaper
  case registrationCertificate
}
