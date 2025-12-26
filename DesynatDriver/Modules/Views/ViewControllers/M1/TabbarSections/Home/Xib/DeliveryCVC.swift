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

    override func awakeFromNib() {
        super.awakeFromNib()
        viewStatus.layer.cornerRadius = 25
        viewStatus.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
    }
    
    
    func configureNewDelivery(data: DeliveryList?) {
        self.lblProductName.text = data?.order?.deliveryDetails?.name ?? ""
        self.lblName.text = data?.productDetails?.sellerDetails?.storeInfo?.storeName ?? ""
        self.lblOrderID.text = "#\(data?.id ?? 0)"

       // 6-confirmed 7-picked 8 not delivered 3-delivered
        if data?.deliveryStatus == "6" {
            lblStatus.text = "Confirmed"
        }else if data?.deliveryStatus == "7" {
            lblStatus.text = "Picked"
        }else if data?.deliveryStatus == "8" {
            lblStatus.text = "Not delivered"
        }else if data?.deliveryStatus == "3" {
            lblStatus.text = "Delivered"
        }else if data?.deliveryStatus == "1" {
            lblStatus.text = "Confirmed"
        }else if data?.deliveryStatus == "2" {
            lblStatus.text = "Confirmed"
        }
    }
    
    func configureOngoingDelivery(data: DeliveryList?) {
        self.lblName.text = data?.order?.deliveryDetails?.name ?? ""
        self.lblProductName.text = data?.productDetails?.sellerDetails?.storeInfo?.storeName ?? ""
        self.lblOrderID.text = "#\(data?.id ?? 0)"

       // 6-confirmed 7-picked 8 not delivered 3-delivered
        if data?.deliveryStatus == "6" {
            lblStatus.text = "Confirmed"
        }else if data?.deliveryStatus == "7" {
            lblStatus.text = "Picked"
        }else if data?.deliveryStatus == "8" {
            lblStatus.text = "Not delivered"
        }else if data?.deliveryStatus == "3" {
            lblStatus.text = "Delivered"
        }else if data?.deliveryStatus == "1" {
            lblStatus.text = "Confirmed"
        }else if data?.deliveryStatus == "2" {
            lblStatus.text = "Confirmed"
        }
    }

}
