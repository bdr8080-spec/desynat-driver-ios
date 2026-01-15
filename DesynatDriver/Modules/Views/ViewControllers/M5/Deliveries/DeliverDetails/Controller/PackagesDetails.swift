//
//  PackagesDetails.swift
//  DesynatDriver
//
//  Created by  shailendra singh on 19/12/25.
//

import UIKit

class PackagesDetails: UIViewController {
  
  //MARK: IBOUTLETS
    
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var exchnageView: UIView!
  @IBOutlet weak var dropLocationLbl: UILabel!
  @IBOutlet weak var customerNameLbl: UILabel!
  @IBOutlet weak var oredrDateLbl: UILabel!
  @IBOutlet weak var orderIdLbl: UILabel!
  @IBOutlet weak var priceLbl: UILabel!
  @IBOutlet weak var painStatusLbl: UILabel!
  @IBOutlet weak var retunrUplaodedImageView: CustomImageView!
  @IBOutlet weak var returnView: UIView!
  @IBOutlet weak var productTableview: TableViewDynamicHeight! {
    didSet {
      productTableview.registerCellFromNib(cellID: "ProductTVC")
    }
  }
  
  //MARK: VARIABLES
  var orderDetail : DeliveryList?
    var comingReason: OrderDeliveryStatus = .newNormalOrder
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setData()
  }
  
  
  func setData() {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    let date = isoFormatter.date(from: orderDetail?.order?.createdAt ?? "")
    self.oredrDateLbl.text = CommonUtils.getDateStrings(from: date, format: "dd/MM/yyyy 'at' hh:mm a")
    self.dropLocationLbl.text = orderDetail?.order?.deliveryDetails?.address ?? ""
    self.customerNameLbl.text = orderDetail?.order?.deliveryDetails?.name ?? ""
    self.orderIdLbl.text = "#\(orderDetail?.id ?? 0)"
    self.priceLbl.text = CommonUtils.formatPriceForString(orderDetail?.order?.totalAmount ?? "")
    if orderDetail?.order?.paymentMethod == "3" {
      self.painStatusLbl.text = "COD"
    }else {
      self.painStatusLbl.text = "Paid"
    }
    self.productTableview.reloadData()
      
      switch comingReason {
      case .newNormalOrder:
          returnView.isHidden = true
          exchnageView.isHidden = true
      case .forReturnOrder:
          returnView.isHidden = false
          exchnageView.isHidden = true
          retunrUplaodedImageView.image = .placeholder
          if let url = URL(string: orderDetail?.returnImage?.first ?? "") {
            retunrUplaodedImageView.sd_setImage(with: url,placeholderImage: .placeholder)
          }
          self.dropLocationLbl.text = self.orderDetail?.productDetails?.sellerDetails?.storeInfo?.storeAddress ?? ""
      case .forExchangeOrder:
          returnView.isHidden = true
          exchnageView.isHidden = false
          self.dropLocationLbl.text = self.orderDetail?.productDetails?.sellerDetails?.storeInfo?.storeAddress ?? ""
          sizeLabel.text = self.orderDetail?.exchangeNewSize
      }
  }
  
  @IBAction func crossBtn(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
}

extension PackagesDetails: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTVC", for: indexPath) as! ProductTVC
    cell.setData(data: self.orderDetail)
    return cell
  }
}
