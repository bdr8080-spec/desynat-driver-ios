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
      if self?.viewModel.orderDetail?.deliveryStatus == "6" {
        self?.lblStatus.text = "Confirmed"
      }else if self?.viewModel.orderDetail?.deliveryStatus == "7" {
        self?.lblStatus.text = "Picked"
      }else if self?.viewModel.orderDetail?.deliveryStatus == "8" {
        self?.lblStatus.text = "Not delivered"
      }else if self?.viewModel.orderDetail?.deliveryStatus == "3" {
        self?.lblStatus.text = "Delivered"
      } else if self?.viewModel.orderDetail?.deliveryStatus == "1" {
        self?.lblStatus.text = "Confirmed"
      }else if self?.viewModel.orderDetail?.deliveryStatus == "2" {
        self?.lblStatus.text = "Confirm"
      }
//      self?.pickupAddressLbl.text = self?.viewModel.orderDetail?.productDetails?.sellerDetails?.storeInfo?.storeAddress ?? ""
      let pickupAddress = self?.viewModel.orderDetail?.productDetails?.sellerDetails?.storeInfo
      self?.pickupAddressLbl.text = "\(pickupAddress?.addressLine1 ?? ""), \(pickupAddress?.addressLine2 ?? ""), \(pickupAddress?.storeAddress ?? ""), \(pickupAddress?.country ?? "")"
      self?.deliveryNamelbl.text = "\(self?.viewModel.orderDetail?.productDetails?.sellerDetails?.firstName ?? "") \(self?.viewModel.orderDetail?.productDetails?.sellerDetails?.lastName ?? "")"
      self?.imgProduct.image = .placeholder
      if let url = URL(string: self?.viewModel.orderDetail?.productDetails?.sellerDetails?.profilePic ?? "") {
        self?.imgProduct.sd_setImage(with: url,placeholderImage: .placeholder)
      }
      self?.ratinglbl.text = "4.5"
//      self?.dropLocationLbl.text = self?.viewModel.orderDetail?.order?.deliveryDetails?.address ?? ""
      let selectedAddress = self?.viewModel.orderDetail?.order?.deliveryDetails
      let addressLine = "\(selectedAddress?.name ?? "")-\(selectedAddress?.houseNo ?? ""), \(selectedAddress?.streetNo ?? ""), \(selectedAddress?.city ?? ""), \(selectedAddress?.state ?? ""), \(selectedAddress?.countryName ?? "")-\(selectedAddress?.postalCode ?? "")"
      self?.dropLocationLbl.text = addressLine
      self?.customerNameLbl.text = self?.viewModel.orderDetail?.order?.deliveryDetails?.name ?? ""
      self?.orderIdLbl.text = "#\(self?.viewModel.orderDetail?.id ?? 0)"
      //CommonUtils.lastSevenWithHash("\(self?.viewModel.orderDetail?.orderID ?? 0)")
      self?.priceLbl.text = CommonUtils.formatAmount(self?.viewModel.orderDetail?.order?.totalAmount ?? "")
      if self?.viewModel.orderDetail?.paymentStatus == "1" {
        self?.painStatusLbl.text = "Paid"
      }else {
        self?.painStatusLbl.text = "Pending"
      }
      self?.lblDistance.text = "\(self?.viewModel.orderDetail?.distance ?? 0) Km"
      self?.productTableview.reloadData()
    }
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
