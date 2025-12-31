//
//  DelivieriesViewModel.swift
//  DesynatDriver
//
//  Created by Chandra Prakash on 24/12/25.
//

import Foundation

enum DeliveriesTab:Int {
case all,new,ongoing,completed
    var title:String {
        switch self {
        case .all:
            "All"
        case .new:
            "New"
        case .ongoing:
            "Ongoing"
        case .completed:
            "Completed"
        }
    }
}

struct FilterInfo {
    var searchText:String = ""
    var deliveryStatus:String = ""
}

extension DeliveriesTab {

    var filterKey: String {
        return "deliveryStatus_\(self.rawValue)"
    }
}

class DeliveriesViewModel {
    
    //MARK: VARIABLES
    // MARK: - Pagination
    var currentPage: Int = 1
    private(set) var totalPage: Int = 1

    // MARK: - Data
    private(set) var orders: [DeliveryList] = []
    var reason: [ReasonListModel] = []
    private(set) var currentTab : DeliveriesTab = .all
    private(set) var filterInfo : FilterInfo = FilterInfo()
    private var searchTimer : Timer?
    var orderDetail : DeliveryList?
    
    // MARK: - Bindings
    var onDataUpdate: (() -> Void)?
    var onNoData: ((Bool) -> Void)?
    
    func changeTab(_ tab: DeliveriesTab) {
        currentTab = tab
        currentPage = 1
        orders.removeAll()
        getData()
    }
    
    func loadSavedFilter() {

        let key = currentTab.filterKey

        if let savedStatus = UserDefaults.standard.value(forKey: key) as? Int {
            filterInfo.deliveryStatus = "\(savedStatus)"
        } else {
            filterInfo.deliveryStatus = ""
        }

        currentPage = 1
        orders.removeAll()
        getData()
    }

    
    func setSearch(_ string:String)  {
        if (searchTimer != nil) {
            searchTimer?.invalidate()
            searchTimer = nil
        }
        self.filterInfo.searchText = string
        self.searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.handleSearch(Timer())
        }
    }
  
   func noDataText(for tab: DeliveriesTab) -> String {
      switch tab {
      case .all:
          return "No deliveries found"
      case .new:
          return "No New deliveries found"
      case .ongoing:
          return "No Ongoing deliveries found"
      case .completed:
          return "No Completed deliveries found"
      }
  }

    
    
    @objc func handleSearch(_ sender: Timer) {
        currentPage = 1
        orders.removeAll()
        getData()
    }

    // MARK: - API Call
    func getData() {

        let limit = 10
        let searchText = filterInfo.searchText
       // let country = filterInfo.deliveryStatus

        var params: [String: Any] = [
            "limit": limit,
            "page": currentPage
        ]

        if !searchText.isEmpty {
            params["search"] = searchText
        }

        if !filterInfo.deliveryStatus.isEmpty {
            params["filter"] = filterInfo.deliveryStatus
        }

        let completion: (DeliveryListModel) -> Void = { data in
            self.totalPage = data.lastPage ?? 1
            if self.currentPage == 1 {
                self.orders = data.data ?? []
            } else {
                self.orders.append(contentsOf: data.data ?? [])
            }
            self.onNoData?(self.orders.isEmpty)
            self.onDataUpdate?()
        }


        switch currentTab {
        case .all:
            WebService.sharedInstance.getAllOrders(parameter: params, completion: completion)

        case .new:
            WebService.sharedInstance.getNewOrders(parameter: params, completion: completion)

        case .ongoing:
            WebService.sharedInstance.getOngoingOrders(parameter: params, completion: completion)

        case .completed:
            WebService.sharedInstance.getCompletedOrders(parameter: params, completion: completion)
        }
    }
    
    func getOrderDetail(orderId: Int, _ completion:@escaping() -> Void) {
        let param: [String: Any] = ["id": orderId]
        WebService.sharedInstance.getOrderDetail(parameter: param) { [weak self] data in
           self?.orderDetail = data
            completion()
        }
    }
    
    func pickOrder(orderId: Int, _ completion:@escaping() -> Void) {
        let param: [String: Any] = ["id": orderId]
        WebService.sharedInstance.pickOrder(parameter: param) { [weak self] data in
            completion()
        }
    }
//  {
//      "id":35,
//      "delivery_status":8, //3-delivered 7-picked 8-not delivered
//       "reason":"order mismatched",
//      "collect_amount":1 //when delivery_status =3 pass to collect payment
//  }
    func updateStatus(orderId: Int,deliveryStatus: String,reason: String, _ completion:@escaping() -> Void) {
        let param: [String: Any] = ["id": orderId, "delivery_status": deliveryStatus, "reason":reason]
        WebService.sharedInstance.updateDeliveryStatus(parameter: param) { [weak self] data in
            completion()
        }
    }
    
    func getReason(completion:@escaping() -> Void) {
        let param: [String: Any] = ["type": "4"]
        WebService.sharedInstance.getReason(parameter: param) { (data) in
            self.reason = data
            completion()
        }
    }
  
  
}
