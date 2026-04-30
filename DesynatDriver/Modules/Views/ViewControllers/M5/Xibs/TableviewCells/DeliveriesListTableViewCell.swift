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
      let isRTL = AppLanguageManager.shared.isRightToLeft
      statusView.layer.cornerRadius = 25
              if isRTL {
                  statusView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
              } else {
                  statusView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMaxYCorner]
              }
      statusView.clipsToBounds = true
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setData(data: DeliveryList?) {
    self.lblName.text = data?.productDetails?.sellerDetails?.storeInfo?.storeName ?? ""
    self.lblPrice.text = CommonUtils.formatPriceForString(data?.order?.totalAmount ?? "")//CommonUtils.formatAmount(data?.order?.totalAmount ?? "")
    self.lblDate.text = CommonUtils.formatISODate(data?.createdAt ?? "")
      let text = "Km".localiz()
    self.lblID.text = "#\(data?.id ?? 0) ● \(data?.distance ?? 0) \(text)"
    self.imgUser.image = .userProfile
    if let url = URL(string: data?.productDetails?.sellerDetails?.storeInfo?.storeImage ?? "") {
      self.imgUser.sd_setImage(with: url,placeholderImage: .userProfile)
    }
    
//    2 onging 3 delivered 4 cancelled 5 return 6 confirmed 7-picked 8-not delivered
    let deliveryStatus = data?.deliveryStatus ?? "1"
    switch deliveryStatus {
      
    case "1", "6":
      lblStatus.text = "Confirmed".localiz()
      statusView.backgroundColor = UIColor(hexString: "#EBFFF5")
      lblStatus.textColor = UIColor(hexString: "#17854C")
      let returnStatus = data?.returnType ?? "0"
      switch returnStatus {
      case "1":
          lblStatus.text = "Return Req.".localiz()
          statusView.backgroundColor = UIColor(hexString: "#FFEAEA")
          lblStatus.textColor = UIColor(hexString: "#FF5F1B")
      case "2":
          lblStatus.text = "Exchange Req.".localiz()
          statusView.backgroundColor = UIColor(hexString: "#FFEAEA")
          lblStatus.textColor = UIColor(hexString: "#FF5F1B")
      default:
          break
      }
        let pOrderdetailsId = data?.pOrderdetailsId ?? "0"
        if pOrderdetailsId != "0" {
            lblStatus.text = "Exchange Req.".localiz()
            statusView.backgroundColor = UIColor(hexString: "#FFEAEA")
            lblStatus.textColor = UIColor(hexString: "#FF5F1B")
        }
    case "2":
      lblStatus.text = "Ongoing".localiz()
      statusView.backgroundColor = UIColor(hexString: "#EBFFF5")
      lblStatus.textColor = UIColor(hexString: "#17854C")
    case "2.1":
        let pOrderdetailsId = data?.pOrderdetailsId ?? "0"
        if pOrderdetailsId != "0" {
            lblStatus.text = "Exchange Req.".localiz()
            statusView.backgroundColor = UIColor(hexString: "#FFEAEA")
            lblStatus.textColor = UIColor(hexString: "#FF5F1B")
        }
    case "3":
      lblStatus.text = "Delivered".localiz()
      statusView.backgroundColor = UIColor(hexString: "#EBFFF5")
      lblStatus.textColor = UIColor(hexString: "#17854C")
//        if data?.returnType == "2" {
            let pOrderdetailsId = data?.pOrderdetailsId ?? "0"
            if pOrderdetailsId != "0" {
                lblStatus.text = "Ongoing".localiz()
                statusView.backgroundColor = UIColor(hexString: "#EBFFF5")
                lblStatus.textColor = UIColor(hexString: "#17854C")
                if data?.returntostore == "1" {
                    lblStatus.text = "Delivered".localiz()
                    statusView.backgroundColor = UIColor(hexString: "#EBFFF5")
                    lblStatus.textColor = UIColor(hexString: "#17854C")
                }
            }
//        }
    case "4":
      lblStatus.text = "Cancelled".localiz()
      statusView.backgroundColor = UIColor(hexString: "#FFEAEA")
      lblStatus.textColor = UIColor(hexString: "#FF5F1B")
    case "5":
      lblStatus.text = "Return Req.".localiz()
      statusView.backgroundColor = UIColor(hexString: "#FFEAEA")
      lblStatus.textColor = UIColor(hexString: "#FF5F1B")
    case "7":
      lblStatus.text = "Picked".localiz()
      statusView.backgroundColor = UIColor(hexString: "#E3F7FF")
      lblStatus.textColor = UIColor(hexString: "#2A74B8")
//        let pOrderdetailsId = data?.pOrderdetailsId ?? "0"
//        if pOrderdetailsId != "0" {
//            lblStatus.text = "Exchange "
//            statusView.backgroundColor = UIColor(hexString: "#EBFFF5")
//            lblStatus.textColor = UIColor(hexString: "#17854C")
//        }
    case "8":
      lblStatus.text = "Not delivered".localiz()
      statusView.backgroundColor = UIColor(hexString: "#FFEAEA")
      lblStatus.textColor = UIColor(hexString: "#EB2525")
    default:
      lblStatus.text = "Ongoing".localiz()
      statusView.backgroundColor = UIColor(hexString: "#EBFFF5")
      lblStatus.textColor = UIColor(hexString: "#17854C")
    }
  }
}
