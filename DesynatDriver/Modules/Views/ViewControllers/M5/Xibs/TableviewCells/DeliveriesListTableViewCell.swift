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
        self.lblName.text = data?.deliveryDetails?.name ?? ""
        self.lblPrice.text = CommonUtils.formatAmount(data?.totalAmount ?? "")
        self.lblDate.text = CommonUtils.formatISODate(data?.createdAt ?? "")
        self.lblID.text = "#\(data?.id ?? 0) ● \(data?.distance ?? 0) Km"
        self.imgUser.image = .userProfile
        if let url = URL(string: data?.orderDetails?.first?.productDetails?.sellerDetails?.storeInfo?.storeImage ?? "") {
            self.imgUser.sd_setImage(with: url,placeholderImage: .userProfile)
        }
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
