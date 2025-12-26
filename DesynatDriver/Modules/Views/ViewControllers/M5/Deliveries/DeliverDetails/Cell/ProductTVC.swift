//
//  ProductTVC.swift
//  DesynatDriver
//
//  Created by Chandra Prakash on 24/12/25.
//

import UIKit

class ProductTVC: UITableViewCell {
    
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productSizeLbl: UILabel!
    @IBOutlet weak var productQuantityLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func setData(data: Order?) {
//        self.productNameLbl.text = data?.productDetails?.productNameEn ?? ""
//        self.productSizeLbl.text = data?.variationDetails?.size?.name ?? ""
//        //self.colourLabel.text = data?.variationDetails?.color?.name ?? ""
//        self.productQuantityLbl.text = data?.quantity?.description
//        self.productImageView.image = .placeholder
//        if let url = URL(string: data?.variationDetails?.variantImage?.first ?? "") {
//            self.productImageView.sd_setImage(with: url,placeholderImage: .placeholder)
//        }
//    }
}
