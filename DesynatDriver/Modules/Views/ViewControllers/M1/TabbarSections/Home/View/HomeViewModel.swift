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
  var newOrders: [DeliveryList] = []
  var ongoingOrders: [DeliveryList] = []
  var completedOrders: [DeliveryList] = []
  
  var onHomeDataUpdate: (() -> Void)?
  
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
  
  private func baseParams(limit: Int = 5) -> [String: Any] {
    return [
      "limit": limit,
      "page": 1
    ]
  }
  
  func getHomeNewOrders() {
    
    WebService.sharedInstance.getNewOrders(parameter: baseParams()) { data in
      self.newOrders = data.data ?? []
      self.onHomeDataUpdate?()
      self.hostVC.lblNewDeliveries.text = "\(data.data?.count ?? 0)"
      if self.newOrders.isEmpty {
        self.hostVC.noDeliveryFoundLabel.isHidden = false
      } else {
        self.hostVC.noDeliveryFoundLabel.isHidden = true
      }
    }
  }
  
  func getHomeOngoingOrders() {
    
    WebService.sharedInstance.getOngoingOrders(parameter: baseParams()) { data in
      self.ongoingOrders = data.data ?? []
      self.onHomeDataUpdate?()
      self.hostVC.lblOnGoingDeliveries.text = "\(data.data?.count ?? 0)"
      if self.ongoingOrders.isEmpty {
        self.hostVC.noOngingDataFoundLabel.isHidden = false
      } else {
        self.hostVC.noOngingDataFoundLabel.isHidden = true
      }
    }
  }
  
  func getHomeCompletedOrders() {
    WebService.sharedInstance.getCompletedOrders(parameter: baseParams()) { data in
      self.completedOrders = data.data ?? []
      self.onHomeDataUpdate?()
      self.hostVC.lblTotalDeliveries.text = "\(data.data?.count ?? 0)"
    }
  }
  
  func getHomeData() {
    getHomeNewOrders()
    getHomeOngoingOrders()
    getHomeCompletedOrders()
  }
  
}
