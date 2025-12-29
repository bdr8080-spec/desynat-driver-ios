//
//  ProfileVC.swift
//  DesynatDriver
//
//  Created by Mohd Faizan on 20/11/25.
//

import UIKit

class ProfileVC: UIViewController {
  
  @IBOutlet weak var detailsStackView: UIStackView!
  @IBOutlet weak var userDetailsView: UIView!
  @IBOutlet weak var vehicleLabel: UILabel!
  @IBOutlet weak var vehicleButtonOutlet: CustomButton!
  @IBOutlet weak var myProfileLabel: UILabel!
  @IBOutlet weak var myProfileButtonOutlet: CustomButton!
  @IBOutlet weak var userProfileImageView: CustomImageView!
  @IBOutlet weak var userNameLaebl: UILabel!
  @IBOutlet weak var userEmailLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var zoneLabel: UILabel!
  
  private lazy var viewModel = ProfileVM(hostVC:self)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.populateDataInProfile()
  }
  
  @IBAction func myProfileDidTapped(_ sender: Any) {

  }
  
  @IBAction func vehicleDidTapped(_ sender: Any) {
    let nextVC = VehicleInfoViewController.instantiate(fromAppStoryboard: .Profile)
    self.navigationController?.pushViewController(nextVC, animated: false)
  }
  
  @IBAction func editDidTapped(_ sender: Any) {
    let nextVC = EditProfileViewController.instantiate(fromAppStoryboard: .Profile)
    nextVC.profileIsUpdated = { [weak self] in
      guard let self else { return }
      viewModel.getDelearProfile()
    }
    self.navigationController?.pushViewController(nextVC, animated: true)
  }
  
  @IBAction func logoutDidTapped(_ sender: Any) {
    self.showConfirmationAlert(msg: "Are you sure you want to logout?"){ [weak self] in
        guard let self = self else { return }
        logoutAPI()
    }
  }
  
  func logoutAPI(){
      WebService.sharedInstance.logoutService() { (response) in
          kSharedSceneDelegate.logoutUser()
      }
  }
}
