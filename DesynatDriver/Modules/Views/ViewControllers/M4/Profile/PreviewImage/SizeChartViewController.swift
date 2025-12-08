//
//  SizeChartViewController.swift
//  DesynatUser
//
//  Created by Rakhi Kumari on 26/11/25.
//


import UIKit
import SDWebImage

class SizeChartViewController: UIViewController {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var titleView: UIView!
  @IBOutlet weak var mainImageView: CustomImageView!
  
  var sizeChartUrl: String? = ""
  var comingReason: ComingReasonUploadDocument = .vehicleImage
  
  override func viewDidLoad() {
        super.viewDidLoad()
    configData()
    initialSetup()
    titleView.layer.cornerRadius = 32
    titleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    titleView.clipsToBounds = true
    }
    

  @IBAction func dismissDidTapped(_ sender: Any) {
    self.dismiss(animated: true)
  }
  
  func configData() {
      if let imageUrlString = sizeChartUrl,
        let url = URL(string: imageUrlString) {
          mainImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
          mainImageView.sd_imageIndicator?.startAnimatingIndicator()
          mainImageView.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
      } else {
          mainImageView.image = UIImage(named: "")
      }
  }
  
  func initialSetup() {
    switch comingReason {
    case .vehicleImage:
      titleLabel.text = "Vehicle Images"
    case .identityProof:
      titleLabel.text = "Identity proof"
      
    case .drivingLicence:
      titleLabel.text = "Driving license"
     
    case .vehcileInsurance:
      titleLabel.text = "Vehicle insurance"
      
    case .pollutionPaper:
      titleLabel.text = "Pollution paper"
      
    case .registrationCertificate:
      titleLabel.text = "Registration Certificate"
    }
  }
  
}
