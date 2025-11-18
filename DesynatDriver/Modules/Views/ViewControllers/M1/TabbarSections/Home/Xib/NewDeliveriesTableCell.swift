//
//  NewDeliveriesTableCell.swift
//  DesynatDriver
//
//  Created by Mohd Faizan on 18/11/25.
//

import UIKit

class NewDeliveriesTableCell: UITableViewCell {
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblOrderID: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewStatus.layer.cornerRadius = 25
        viewStatus.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
    }

    @IBAction func btnTapViewAll(_ sender: UIButton) {
    }
    
    @IBAction func btnTapCall(_ sender: UIButton) {
    }
    
}
