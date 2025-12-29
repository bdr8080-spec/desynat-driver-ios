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
  @IBOutlet weak var productQuantityLbl: UILabel!
  @IBOutlet weak var detailsLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func setData(data: DeliveryList?) {
    productNameLbl.text = data?.productDetails?.productNameEn ?? ""
    setColorBox(size: data?.variationDetails?.size?.name ?? "M", label: detailsLabel, hexColor: data?.variationDetails?.color?.hexCode ?? "#98ADFF")
    productQuantityLbl.text = data?.quantity?.description
    productImageView.image = .placeholder
    if let url = URL(string: data?.variationDetails?.variantImage?.first ?? "") {
      productImageView.sd_setImage(with: url,placeholderImage: .placeholder)
    }
  }
  
  func setColorBox(size: String, label: UILabel, hexColor: String) {
      
      // Use this square → fully tintable solid square
      let coloredSquare = "■"
      let dot = "●"
      
      let fullText = "Size: \(size)  \(dot)  Color: \(coloredSquare)  \(dot)"
      
      let attributedString = NSMutableAttributedString(
          string: fullText,
          attributes: [
              .font: UIFont(name: "Poppins-Light", size: 10.0) ?? UIFont.systemFont(ofSize: 10)
          ]
      )
      
      let grayColor = UIColor(hexString: "#D9D9D9") ?? UIColor.gray
      let nsText = fullText as NSString
      
      // Gray dots
      var searchRange = NSRange(location: 0, length: nsText.length)
      while true {
          let range = nsText.range(of: dot, options: [], range: searchRange)
          if range.location == NSNotFound { break }
          attributedString.addAttribute(.foregroundColor, value: grayColor, range: range)
          
          let nextLoc = range.location + range.length
          searchRange = NSRange(location: nextLoc, length: nsText.length - nextLoc)
      }
      
      // Colored square with API color + slightly larger
      if let productColor = UIColor(hexStringBox: hexColor) {
          let squareRange = nsText.range(of: coloredSquare)
          if squareRange.location != NSNotFound {
              attributedString.addAttribute(.foregroundColor, value: productColor, range: squareRange)
              // Make the square pop (bigger + medium weight)
              attributedString.addAttribute(.font, value: UIFont(name: "Poppins-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .medium), range: squareRange)
          }
      }
      
      label.attributedText = attributedString
  }
}

extension UIColor {
    convenience init?(hexStringBox: String) {
        var hexFormatted = hexStringBox.trimmingCharacters(in: .whitespacesAndNewlines)
        hexFormatted = hexFormatted.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let g = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let b = CGFloat(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
