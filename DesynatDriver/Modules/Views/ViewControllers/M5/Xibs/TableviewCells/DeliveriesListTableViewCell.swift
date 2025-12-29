//
//  DeliveriesListTableViewCell.swift
//  DesynatDriver
//
//  Created by fluper on 18/12/25.
//

import UIKit

class DeliveriesListTableViewCell: UITableViewCell {
  
  //MARK: IBOUTLETS
  @IBOutlet weak var statusView: UIView!
  @IBOutlet weak var lblName: UILabel!
  @IBOutlet weak var lblStatus: UILabel!
  @IBOutlet weak var lblDate: UILabel!
  @IBOutlet weak var lblID: UILabel!
  @IBOutlet weak var lblPrice: UILabel!
  @IBOutlet weak var imgUser: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    statusView.layer.cornerRadius = 25
    statusView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMaxYCorner]
    statusView.clipsToBounds = true
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setData(data: DeliveryList?) {
    self.lblName.text = data?.order?.deliveryDetails?.name ?? ""
    self.lblPrice.text = CommonUtils.formatAmount(data?.order?.totalAmount ?? "")
    self.lblDate.text = CommonUtils.formatISODate(data?.createdAt ?? "")
    self.lblID.text = "#\(data?.id ?? 0) ● \(data?.distance ?? 0) Km"
    self.imgUser.image = .userProfile
    if let url = URL(string: data?.productDetails?.sellerDetails?.storeInfo?.storeImage ?? "") {
      self.imgUser.sd_setImage(with: url,placeholderImage: .userProfile)
    }
    
//    2 onging 3 delivered 4 cancelled 5 return 6 confirmed 7-picked 8-not delivered
    let deliveryStatus = data?.deliveryStatus ?? "1"
    switch deliveryStatus {
    case "1", "6":
      lblStatus.text = "Confirmed"
      statusView.backgroundColor = UIColor(hexString: "#EBFFF5")
      lblStatus.textColor = UIColor(hexString: "#17854C")
    case "2":
      lblStatus.text = "Ongoing"
      statusView.backgroundColor = UIColor(hexString: "#EBFFF5")
      lblStatus.textColor = UIColor(hexString: "#17854C")
    case "3":
      lblStatus.text = "Delivered"
      statusView.backgroundColor = UIColor(hexString: "#EBFFF5")
      lblStatus.textColor = UIColor(hexString: "#17854C")
    case "4":
      lblStatus.text = "Cancelled"
      statusView.backgroundColor = UIColor(hexString: "#FFEAEA")
      lblStatus.textColor = UIColor(hexString: "#FF5F1B")
    case "5":
      lblStatus.text = "Return Req."
      statusView.backgroundColor = UIColor(hexString: "#FFEAEA")
      lblStatus.textColor = UIColor(hexString: "#FF5F1B")
    case "7":
      lblStatus.text = "Picked"
      statusView.backgroundColor = UIColor(hexString: "#E3F7FF")
      lblStatus.textColor = UIColor(hexString: "#2A74B8")
    case "8":
      lblStatus.text = "Not delivered"
      statusView.backgroundColor = UIColor(hexString: "#FFEAEA")
      lblStatus.textColor = UIColor(hexString: "#EB2525")
    default:
      lblStatus.text = "Ongoing"
      statusView.backgroundColor = UIColor(hexString: "#EBFFF5")
      lblStatus.textColor = UIColor(hexString: "#17854C")
    }
  }
}
