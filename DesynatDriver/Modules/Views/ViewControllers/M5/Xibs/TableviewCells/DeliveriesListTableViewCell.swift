//
//  DeliveriesListTableViewCell.swift
//  DesynatDriver
//
//  Created by fluper on 18/12/25.
//

import UIKit

class DeliveriesListTableViewCell: UITableViewCell {

  @IBOutlet weak var statusView: UIView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
    statusView.layer.cornerRadius = 25
    statusView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMaxYCorner]
    statusView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
