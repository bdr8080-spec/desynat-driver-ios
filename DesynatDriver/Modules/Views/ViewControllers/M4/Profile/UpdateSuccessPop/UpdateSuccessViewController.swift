//
//  UpdateSuccessViewController.swift
//  DesynatDriver
//
//  Created by fluper on 04/12/25.
//

import UIKit

class UpdateSuccessViewController: UIViewController {

  @IBOutlet weak var titleLabel: UILabel!
  
  var callBackDismiss: (()->())?
  var comingReason: ComingReasonUpdateSuccess = .vehicleName
  
    override func viewDidLoad() {
        super.viewDidLoad()
      initialSetup()
      DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
          self.dismiss(animated: true) {
              self.callBackDismiss?()
          }
      }
    }

  func initialSetup() {
    switch comingReason {
    case .vehicleName:
      titleLabel.text = "Your change request for\nVehicle Name  on Desynat app is\nunder review !! Please wait for 3-4 hrs"
    case .updateVehicleRegistration:
      titleLabel.text = "Your change request for\nVehicle Registration No. on Desynat app is\nunder review !! Please wait for 3-4 hrs"
    case .vehicleImage:
      titleLabel.text = "Your change request for\nVehicle Images on Desynat app is\nunder review !! Please wait for 3-4 hrs"
    case .identityProof:
      titleLabel.text = "Your change request for\nIdentity proof on Desynat app is\nunder review !! Please wait for 3-4 hrs"
    case .drivingLicence:
      titleLabel.text = "Your change request for\nDriving license on Desynat app is\nunder review !! Please wait for 3-4 hrs"
    case .vehcileInsurance:
      titleLabel.text = "Your change request for\nVehicle insurance on Desynat app is\nunder review !! Please wait for 3-4 hrs"
    case .pollutionPaper:
      titleLabel.text = "Your change request for\nPollution paper on Desynat app is\nunder review !! Please wait for 3-4 hrs"
    case .registrationCertificate:
      titleLabel.text = "Your change request for\nRegistration Certificate on Desynat app is\nunder review !! Please wait for 3-4 hrs"
    }
  }
  
}

enum ComingReasonUpdateSuccess {
  case vehicleName
  case updateVehicleRegistration
  case vehicleImage
  case identityProof
  case drivingLicence
  case vehcileInsurance
  case pollutionPaper
  case registrationCertificate
}
