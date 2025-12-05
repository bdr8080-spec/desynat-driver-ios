//
//  EditProfileViewController.swift
//  DesynatDriver
//
//  Created by fluper on 04/12/25.
//

import UIKit

class EditProfileViewController: UIViewController {
  
  @IBOutlet weak var fullNameInEnglishTF: UITextField!
  @IBOutlet weak var fullNameInArabicTF: UITextField!
  @IBOutlet weak var profileImageView: CustomImageView!
  @IBOutlet weak var firstNameTF: UITextField!
  @IBOutlet weak var lastNameTF: UITextField!
  @IBOutlet weak var mobileTF: UITextField!
  @IBOutlet weak var countryCodeTF: UITextField!
  @IBOutlet weak var emailTF: UITextField!
  @IBOutlet weak var addressLineTF: UITextField!
  @IBOutlet weak var cityTF: UITextField!
  @IBOutlet weak var stateTF: UITextField!
  @IBOutlet weak var houseNumberTF: UITextField!
  @IBOutlet weak var blockNumberTF: UITextField!
  @IBOutlet weak var postalTF: UITextField!
  @IBOutlet weak var zoneTF: UITextField!
  
  var zoneId: Int? = 0
  var latitude: Double? = 0.0
  var longitude: Double? = 0.0
  var profileImageUrl: String = ""
  private lazy var viewModel = EditProfileViewModel(hostVC: self)
  var profileIsUpdated: (() -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    viewModel.getAllZone()
    fillDriverData(data: driverProfileData)
  }
  
  @IBAction func backDidTapped(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func profileImageDidTapped(_ sender: Any) {
    ImagePickerManager().pickImage(self) { [weak self] image, fileName, url in
        guard let self = self else { return }
        self.viewModel.uploadDocument(file: image, isImage: true) { [weak self] uploadedUrl in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.profileImageUrl = uploadedUrl
                self.profileImageView.image = image
            }
        }
    }
  }
  
  @IBAction func zoneDidTapped(_ sender: UIButton) {
    let zoneNames = viewModel.zoneListData.map { country -> String in
      let name = country.nameEnglish ?? ""
      return "\(name)"
    }
    kSharedAppDelegate.dropDown(dataSource: zoneNames, anchorView: sender) { index, item in
      let selectedCountry = self.viewModel.zoneListData[index]
      self.zoneTF.text = selectedCountry.nameEnglish
      self.zoneId = selectedCountry.id
    }
  }
  
  @IBAction func addLocationDidTapped(_ sender: Any) {
    let vc = LocationViewController.instantiate(fromAppStoryboard: .Profile)
    vc.preSelectedLat = self.latitude
    vc.preSelectedLng = self.longitude
    vc.locationCallBack = { [weak self] address, locality, city, state, country, pincode, lat, long in
      guard let self = self else { return }
      let safeLocality = locality.isEmpty ? address : locality
      let safeCity = city.isEmpty ? locality.isEmpty ? address : locality : city
      let safeState = state.isEmpty ? city.isEmpty ? locality.isEmpty ? address : locality : city : state
      let safePincode = pincode.isEmpty ? "" : pincode
      self.addressLineTF.text = safeLocality
      var components: [String] = []
      if !safeCity.isEmpty { components.append(safeCity) }
      if !safeState.isEmpty { components.append(safeState) }
      var addressLine2 = components.joined(separator: ", ")
      if !safePincode.isEmpty { addressLine2 += " - \(safePincode)" }
      if addressLine2.isEmpty { addressLine2 = address }
      self.houseNumberTF.text = addressLine2
      self.cityTF.text = safeCity.isEmpty ? address : safeCity
      self.stateTF.text = safeState.isEmpty ? safeCity.isEmpty ? address : safeCity : safeState
      self.latitude = lat
      self.longitude = long
    }
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  @IBAction func saveChangesDidTapped(_ sender: Any) {
    if viewModel.validateFields() {
      viewModel.editDriverProfileApi()
    }
  }
  
  func fillDriverData(data: UserProfileData?) {
    // MARK: - Text Fields
//    let fullName = splitName(data?.fullNameEnglish ?? "")
//    firstNameTF.text = fullName.firstName
//    lastNameTF.text = fullName.lastName
    fullNameInEnglishTF.text = data?.fullNameEnglish
    fullNameInArabicTF.text = data?.fullNameArabic
    mobileTF.text = data?.mobile
    countryCodeTF.text = data?.countryCode
    emailTF.text = data?.email
    addressLineTF.text = data?.addressLine1
    houseNumberTF.text = data?.addressLine2
    //    blockNumberTF.text = data?.house
//    postalTF.text = data?.postalCode
    cityTF.text = data?.city
    stateTF.text = data?.state
    zoneTF.text = data?.zoneInfo?.nameEnglish
    
    // MARK: - Image URLs Assignment (required for API)
    zoneId = data?.zoneInfo?.id
    latitude = Double(data?.latitude ?? "0.0")
    longitude = Double(data?.long ?? "0.0")
    profileImageUrl = data?.profilePic ?? ""
    
    // MARK: - Show Images
    profileImageView.setImage(with: data?.profilePic)
  }
  
  func splitName(_ fullName: String) -> (firstName: String, lastName: String) {
      let parts = fullName
          .trimmingCharacters(in: .whitespacesAndNewlines)
          .split(separator: " ")
          .map { String($0) }
      guard !parts.isEmpty else {
          return ("", "")
      }
      if parts.count == 1 {
          return (parts[0], "")
      }
      return (parts.first ?? "", parts.last ?? "")
  }

}
