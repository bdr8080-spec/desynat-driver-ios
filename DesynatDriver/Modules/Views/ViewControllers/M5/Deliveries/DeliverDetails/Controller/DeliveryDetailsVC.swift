//
//  DeliveryDetailsVC.swift
//  DesynatDriver
//
//  Created by  shailendra singh on 19/12/25.
//

import UIKit
import Cosmos

class DeliveryDetailsVC: UIViewController {
  
  //MARK: VARIABLES
  @IBOutlet weak var ratingView: CosmosView!
  @IBOutlet weak var LbldeliveredID: UILabel!
  @IBOutlet weak var LbldeliveredOn: UILabel!
  @IBOutlet weak var pickupAddressLbl: UILabel!
  @IBOutlet weak var deliveryNamelbl: UILabel!
  @IBOutlet weak var ratinglbl: UILabel!
  @IBOutlet weak var dropLocationLbl: UILabel!
  @IBOutlet weak var customerNameLbl: UILabel!
  @IBOutlet weak var oredrDateLbl: UILabel!
  @IBOutlet weak var orderIdLbl: UILabel!
  @IBOutlet weak var priceLbl: UILabel!
  @IBOutlet weak var painStatusLbl: UILabel!
  @IBOutlet weak var dropLocationView: UIView!
  @IBOutlet weak var pickupView: UIView!
  @IBOutlet weak var lblStatus: UILabel!
  @IBOutlet weak var lblDistance: UILabel!
  @IBOutlet weak var imgProduct: UIImageView!
  
  @IBOutlet weak var notDeliveryLabel: UILabel!
  @IBOutlet weak var reasonView: UIView!
  @IBOutlet weak var productTableview: TableViewDynamicHeight! {
    didSet {
      productTableview.registerCellFromNib(cellID: "ProductTVC")
    }
  }
  
  //MARK: VARIABLES
  let viewModel = DeliveriesViewModel()
  var orderId:Int?
  
  //MARK: VIEW LIFE CYCLE
  override func viewDidLoad() {
    super.viewDidLoad()
//    viewSet()
    setData()
  }
  
  func setData() {
    self.viewModel.getOrderDetail(orderId: self.orderId ?? 0) { [weak self] in
      self?.LbldeliveredID.text = "#\(self?.viewModel.orderDetail?.id ?? 0)"
      
      let isoFormatter = ISO8601DateFormatter()
      isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
      let date = isoFormatter.date(from: self?.viewModel.orderDetail?.createdAt ?? "")
      self?.LbldeliveredOn.text = CommonUtils.getDateStrings(from: date, format: "dd/MM/yyyy 'at' hh:mm a")
      self?.oredrDateLbl.text = CommonUtils.getDateStrings(from: date, format: "dd/MM/yyyy 'at' hh:mm a")
      self?.lblStatus.textColor = UIColor(hex: "#17854C")
      if self?.viewModel.orderDetail?.deliveryStatus == "6" {
        self?.lblStatus.text = "Confirmed"
      }else if self?.viewModel.orderDetail?.deliveryStatus == "7" {
        self?.lblStatus.text = "Picked"
      }else if self?.viewModel.orderDetail?.deliveryStatus == "8" {
        self?.lblStatus.text = "Not delivered"
        self?.lblStatus.textColor = UIColor.red
        self?.reasonView.isHidden = false
        self?.notDeliveryLabel.text = self?.viewModel.orderDetail?.notDeliveredReason
      }else if self?.viewModel.orderDetail?.deliveryStatus == "3" {
        self?.lblStatus.text = "Delivered"
      } else if self?.viewModel.orderDetail?.deliveryStatus == "1" {
        self?.lblStatus.text = "Confirmed"
      }else if self?.viewModel.orderDetail?.deliveryStatus == "2" {
        self?.lblStatus.text = "Confirm"
      }
      self?.pickupAddressLbl.text = self?.viewModel.orderDetail?.productDetails?.sellerDetails?.storeInfo?.storeAddress ?? ""
//      let pickupAddress = self?.viewModel.orderDetail?.productDetails?.sellerDetails?.storeInfo
//      self?.pickupAddressLbl.text = "\(pickupAddress?.addressLine1 ?? ""), \(pickupAddress?.addressLine2 ?? ""), \(pickupAddress?.storeAddress ?? ""), \(pickupAddress?.country ?? "")"
      self?.deliveryNamelbl.text = self?.viewModel.orderDetail?.productDetails?.sellerDetails?.storeInfo?.storeName
      self?.imgProduct.image = .placeholder
      if let url = URL(string: self?.viewModel.orderDetail?.productDetails?.sellerDetails?.storeInfo?.storeImage ?? "") {
        self?.imgProduct.sd_setImage(with: url,placeholderImage: .placeholder)
      }
      
//      self?.dropLocationLbl.text = self?.viewModel.orderDetail?.order?.deliveryDetails?.address ?? ""
      let selectedAddress = self?.viewModel.orderDetail?.order?.deliveryDetails
//      let addressLine = "\(selectedAddress?.houseNo ?? ""), \(selectedAddress?.streetNo ?? ""), \(selectedAddress?.city ?? ""), \(selectedAddress?.state ?? ""), \(selectedAddress?.countryName ?? "")-\(selectedAddress?.postalCode ?? "")"
//      self?.dropLocationLbl.text = addressLine
      self?.dropLocationLbl.text = self?.formattedAddress(from: selectedAddress)

      self?.customerNameLbl.text = self?.viewModel.orderDetail?.order?.deliveryDetails?.name ?? ""
      self?.orderIdLbl.text = "#\(self?.viewModel.orderDetail?.id ?? 0)"
      //CommonUtils.lastSevenWithHash("\(self?.viewModel.orderDetail?.orderID ?? 0)")
//      self?.priceLbl.text = CommonUtils.formatAmount(self?.viewModel.orderDetail?.order?.totalAmount ?? "")
      self?.priceLbl.text = CommonUtils.formatPriceForString(self?.viewModel.orderDetail?.order?.totalAmount ?? "")
      if self?.viewModel.orderDetail?.order?.paymentMethod == "3" {
        self?.painStatusLbl.text = "COD"
      }else {
        self?.painStatusLbl.text = "Paid"
      }
      self?.lblDistance.text = "\(self?.viewModel.orderDetail?.distance ?? 0) Km"
      self?.productTableview.reloadData()
      
      if self?.viewModel.orderDetail?.userRatingReviewProvide == nil {
        self?.ratingView.rating = 0
        self?.ratinglbl.text = "0"
      } else {
        let rating = Double(self?.viewModel.orderDetail?.userRatingReviewProvide?.storeRating ?? "") ?? 0
        self?.ratingView.rating = rating
        self?.ratinglbl.text = self?.viewModel.orderDetail?.userRatingReviewProvide?.storeRating
      }
    }
  }
  
  func formattedAddress(from address: DeliveryDetails?) -> String {
      var addressParts: [String] = []

      if let houseNo = address?.houseNo, !houseNo.isEmpty {
          addressParts.append(houseNo)
      }

      if let streetNo = address?.streetNo, !streetNo.isEmpty {
          addressParts.append(streetNo)
      }

      if let city = address?.city, !city.isEmpty {
          addressParts.append(city)
      }

      if let state = address?.state, !state.isEmpty {
          addressParts.append(state)
      }

      if let country = address?.countryName, !country.isEmpty {
          addressParts.append(country)
      }

      // Join address parts with comma
      var addressLine = addressParts.joined(separator: ", ")

      // Add postal code only if available
      if let postalCode = address?.postalCode, !postalCode.isEmpty {
          addressLine += " - \(postalCode)"
      }

      return addressLine
  }

  
  @IBAction func backBtn(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
//  func viewSet() {
//    dropLocationView.layer.cornerRadius = 10
//    pickupView.layer.cornerRadius = 10
//    
//    dropLocationView.layer.borderWidth = 1
//    pickupView.layer.borderWidth = 1
//    
//    dropLocationView.layer.borderColor = UIColor.lightGray.cgColor
//    pickupView.layer.borderColor = UIColor.lightGray.cgColor
//  }
}

extension DeliveryDetailsVC: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTVC", for: indexPath) as! ProductTVC
     cell.setData(data: self.viewModel.orderDetail)
    return cell
  }
}
