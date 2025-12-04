//
//  HomeViewModel.swift
//  DesynatDriver
//
//  Created by fluper on 04/12/25.
//


import Foundation
import UIKit

class HomeViewModel {
  
  private var hostVC: HomeViewController
  var storeAvailabilityModel: UserAvailability?
  
  init(hostVC: HomeViewController) {
    self.hostVC = hostVC
  }
  
  func statusUpdateAPI(completion: @escaping (Bool) -> Void) {
    let param: [String: Any] = ["delivery_boy_id": driverProfileData?.id ?? ""]
    WebService.sharedInstance.dutyStatusUpdateService(param: param){ [weak self] response in
      guard let self = self else { return }
      self.storeAvailabilityModel = response
      completion(true)
    }
  }
  
  func getDelearProfile() {
    WebService.sharedInstance.getProfile { [weak self] response in
      guard let self = self else { return }
      driverProfileData = response
      DispatchQueue.main.async {
        let dutyStatus = response.onDuty ?? "1"
        self.hostVC.btnToggle.setImage(
          UIImage(named: dutyStatus == "1" ? "toggle" : "toggle_off"),
          for: .normal
        )
        self.hostVC.busyOnOffLabel.text = dutyStatus == "1" ? "On Duty" : "Off Duty"
      }
    }
  }
  
}
