//
//  DeliveryCVC.swift
//  DesynatDriver
//
//  Created by Chandra Prakash on 26/12/25.
//

import UIKit

class DeliveryCVC: UICollectionViewCell {
    
    @IBOutlet weak var lblOrderID: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var lblOrderIdTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewStatus.layer.cornerRadius = 25
        viewStatus.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        lblOrderIdTitle.text = "Order ID".localiz()
        let isRTL = AppLanguageManager.shared.isRightToLeft
        viewStatus.layer.cornerRadius = 25
                if isRTL {
                    viewStatus.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
                } else {
                    viewStatus.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMaxYCorner]
                }
        viewStatus.clipsToBounds = true
    }
    
    
    func configureNewDelivery(data: DeliveryList?) {
      let fullName = "\(data?.productDetails?.sellerDetails?.firstName ?? "") \(data?.productDetails?.sellerDetails?.lastName ?? "")"
      self.lblProductName.text = fullName//data?.productDetails?.sellerDetails?.firstName
        self.lblName.text = data?.productDetails?.sellerDetails?.storeInfo?.storeName ?? ""
        self.lblOrderID.text = "#\(data?.id ?? 0)"
      viewStatus.backgroundColor = UIColor(hexString: "#EBFFF5")
      lblStatus.textColor = UIColor.init(hexString: "#17854C")
       // 6-confirmed 7-picked 8 not delivered 3-delivered
      if data?.deliveryStatus == "1" {
        let returnStatus = data?.returnType ?? "0"
        switch returnStatus {
        case "1":
          lblStatus.text = "Return Req.".localiz()
          viewStatus.backgroundColor = UIColor(hexString: "#FFEAEA")
          lblStatus.textColor = UIColor(hexString: "#FF5F1B")
            
        case "2":
          lblStatus.text = "Exchange Req.".localiz()
          viewStatus.backgroundColor = UIColor(hexString: "#FFEAEA")
          lblStatus.textColor = UIColor(hexString: "#FF5F1B")
        default:
          break
        }
          let pOrderdetailsId = data?.pOrderdetailsId ?? "0"
          if pOrderdetailsId != "0" {
              lblStatus.text = "Exchange Req.".localiz()
              viewStatus.backgroundColor = UIColor(hexString: "#FFEAEA")
              lblStatus.textColor = UIColor(hexString: "#FF5F1B")
          }
      }else if data?.deliveryStatus == "6" {
            lblStatus.text = "Confirmed".localiz()
        }else if data?.deliveryStatus == "7" {
            lblStatus.text = "Picked".localiz()
        }else if data?.deliveryStatus == "8" {
            lblStatus.text = "Not delivered".localiz()
        }else if data?.deliveryStatus == "3" {
            lblStatus.text = "Delivered".localiz()
//            if data?.returnType == "2" {
                let pOrderdetailsId = data?.pOrderdetailsId ?? "0"
                if pOrderdetailsId != "0" {
                    lblStatus.text = "Ongoing".localiz()
                }
//            }
        }else if data?.deliveryStatus == "1" {
            lblStatus.text = "Confirmed".localiz()
            let pOrderdetailsId = data?.pOrderdetailsId ?? "0"
            if pOrderdetailsId != "0" {
                lblStatus.text = "Exchange Req.".localiz()
                viewStatus.backgroundColor = UIColor(hexString: "#FFEAEA")
                lblStatus.textColor = UIColor(hexString: "#FF5F1B")
            }
        }else if data?.deliveryStatus == "2" {
            lblStatus.text = "Confirmed".localiz()
        } else if data?.deliveryStatus == "2.1" {
            let pOrderdetailsId = data?.pOrderdetailsId ?? "0"
            if pOrderdetailsId != "0" {
                lblStatus.text = "Exchange Req.".localiz()
                viewStatus.backgroundColor = UIColor(hexString: "#FFEAEA")
                lblStatus.textColor = UIColor(hexString: "#FF5F1B")
            }
        }
    }
    
    func configureOngoingDelivery(data: DeliveryList?) {
      
      self.lblProductName.text = data?.order?.userDetails?.fullName ?? ""
      self.lblName.text = data?.productDetails?.sellerDetails?.storeInfo?.storeName ?? ""
        self.lblOrderID.text = "#\(data?.id ?? 0)"
      viewStatus.backgroundColor = UIColor(hexString: "#E3F7FF")
      lblStatus.textColor = UIColor.init(hexString: "#2A74B8")
       // 6-confirmed 7-picked 8 not delivered 3-delivered
      if data?.deliveryStatus == "1" {
        let returnStatus = data?.returnType ?? "0"
        switch returnStatus {
        case "1":
          lblStatus.text = "Return Req.".localiz()
          viewStatus.backgroundColor = UIColor(hexString: "#FFEAEA")
          lblStatus.textColor = UIColor(hexString: "#FF5F1B")
        case "2":
          lblStatus.text = "Exchange Req.".localiz()
          viewStatus.backgroundColor = UIColor(hexString: "#FFEAEA")
          lblStatus.textColor = UIColor(hexString: "#FF5F1B")
        default:
          break
        }
          let pOrderdetailsId = data?.pOrderdetailsId ?? "0"
          if pOrderdetailsId != "0" {
              lblStatus.text = "Exchange Req.".localiz()
              viewStatus.backgroundColor = UIColor(hexString: "#FFEAEA")
              lblStatus.textColor = UIColor(hexString: "#FF5F1B")
          }
      }else if data?.deliveryStatus == "6" {
            lblStatus.text = "Confirmed".localiz()
        }else if data?.deliveryStatus == "7" {
            lblStatus.text = "Picked".localiz()
        }else if data?.deliveryStatus == "8" {
            lblStatus.text = "Not delivered".localiz()
        }else if data?.deliveryStatus == "3" {
            lblStatus.text = "Delivered".localiz()
//            if data?.returnType == "2" {
                let pOrderdetailsId = data?.pOrderdetailsId ?? "0"
                if pOrderdetailsId != "0" {
                    lblStatus.text = "Ongoing".localiz()
                }
//            }
        }else if data?.deliveryStatus == "1" {
            lblStatus.text = "Confirmed".localiz()
            let pOrderdetailsId = data?.pOrderdetailsId ?? "0"
            if pOrderdetailsId != "0" {
                lblStatus.text = "Exchange Req.".localiz()
                viewStatus.backgroundColor = UIColor(hexString: "#FFEAEA")
                lblStatus.textColor = UIColor(hexString: "#FF5F1B")
            }
        }else if data?.deliveryStatus == "2" {
            lblStatus.text = "Confirmed".localiz()
        } else if data?.deliveryStatus == "2.1" {
            let pOrderdetailsId = data?.pOrderdetailsId ?? "0"
            if pOrderdetailsId != "0" {
                lblStatus.text = "Exchange Req.".localiz()
                viewStatus.backgroundColor = UIColor(hexString: "#FFEAEA")
                lblStatus.textColor = UIColor(hexString: "#FF5F1B")
            }
        }
    }

}
