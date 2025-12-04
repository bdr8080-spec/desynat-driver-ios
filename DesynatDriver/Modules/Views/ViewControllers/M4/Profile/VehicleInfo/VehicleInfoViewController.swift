//
//  VehicleInfoViewController.swift
//  DesynatDriver
//
//  Created by fluper on 04/12/25.
//

import UIKit

class VehicleInfoViewController: UIViewController {
  
  @IBOutlet weak var registrtionCertificateView: UIView!
  @IBOutlet weak var pollutionCertificateView: UIView!
  @IBOutlet weak var vehicleNameTF: UITextField!
  @IBOutlet weak var registrationTF: UITextField!
  @IBOutlet weak var vehicleImageFrontImageView: CustomImageView!
  @IBOutlet weak var vehicleImageBackImageView: CustomImageView!
  @IBOutlet weak var identityProofFrontImageView: CustomImageView!
  @IBOutlet weak var identityProofBackImageView: CustomImageView!
  @IBOutlet weak var drivingLcenseFrontImageView: CustomImageView!
  @IBOutlet weak var drivingLcenseBackImageView: CustomImageView!
  @IBOutlet weak var vehicleInsuranceImageView: CustomImageView!
  @IBOutlet weak var pollutionPaperImageView: CustomImageView!
  @IBOutlet weak var registrationCertificationFrontImagViw: CustomImageView!
  @IBOutlet weak var registrationCertificationBackImagViw: CustomImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      fillDriverData(data: driverProfileData)
    }
  
  @IBAction func myProfileDidTapped(_ sender: Any) {
    self.navigationController?.popViewController(animated: false)
  }
  
  @IBAction func backDidTapped(_ sender: Any) {
    self.navigationController?.popViewController(animated: false)
  }
  
  @IBAction func vehcileNameDidTapped(_ sender: Any) {
    let nextVC = UpdateVehicleViewController.instantiate(fromAppStoryboard: .Profile)
    nextVC.comingReason = .vehicleName
    self.navigationController?.present(nextVC, animated: true)
  }
  
  @IBAction func registrationNumberDidTappd(_ sender: Any) {
    let nextVC = UpdateVehicleViewController.instantiate(fromAppStoryboard: .Profile)
    nextVC.comingReason = .updateVehicleRegistration
    self.navigationController?.present(nextVC, animated: true)
  }
  
  @IBAction func uploadVehicleDidTapped(_ sender: Any) {
    let nextVC = UploadDocumentViewController.instantiate(fromAppStoryboard: .Profile)
    nextVC.comingReason = .vehicleImage
    self.navigationController?.present(nextVC, animated: true)
  }
  
  @IBAction func uploadIdentityDidTapped(_ sender: Any) {
    let nextVC = UploadDocumentViewController.instantiate(fromAppStoryboard: .Profile)
    nextVC.comingReason = .identityProof
    self.navigationController?.present(nextVC, animated: true)
  }
  
  @IBAction func drivingLicenseDidTapped(_ sender: Any) {
    let nextVC = UploadDocumentViewController.instantiate(fromAppStoryboard: .Profile)
    nextVC.comingReason = .drivingLicence
    self.navigationController?.present(nextVC, animated: true)
  }
  
  @IBAction func vehicleInsuranceDidTapped(_ sender: Any) {
    let nextVC = UploadDocumentViewController.instantiate(fromAppStoryboard: .Profile)
    nextVC.comingReason = .vehcileInsurance
    self.navigationController?.present(nextVC, animated: true)
  }
  
  @IBAction func pollutionCertificateDidTapped(_ sender: Any) {
    let nextVC = UploadDocumentViewController.instantiate(fromAppStoryboard: .Profile)
    nextVC.comingReason = .pollutionPaper
    self.navigationController?.present(nextVC, animated: true)
  }
  
  @IBAction func registrationCertificateDidTapped(_ sender: Any) {
    let nextVC = UploadDocumentViewController.instantiate(fromAppStoryboard: .Profile)
    nextVC.comingReason = .registrationCertificate
    self.navigationController?.present(nextVC, animated: true)
  }
  
  func fillDriverData(data: UserProfileData?) {
      // MARK: - Text Fields
    vehicleNameTF.text = data?.vehicleName
    registrationTF.text = data?.vehicleRegNo
      // MARK: - Show Images
    
    let pollutionUrl = data?.pollutionPaper?.first?.documentPath ?? ""
    pollutionCertificateView.isHidden = pollutionUrl.isEmpty
    vehicleImageFrontImageView.setImage(with: data?.vehicleImage?.first(where: { $0.isFront == 1})?.documentPath ?? "uploadFront")
    vehicleImageBackImageView.setImage(with: data?.vehicleImage?.first(where: { $0.isFront == 0})?.documentPath ?? "uplaodBack")
      
    identityProofFrontImageView.setImage(with: data?.identityProof?.first(where: { $0.isFront == 1})?.documentPath ?? "uploadFront")
    identityProofBackImageView.setImage(with: data?.identityProof?.first(where: { $0.isFront == 0})?.documentPath ?? "uplaodBack")
      
    drivingLcenseFrontImageView.setImage(with: data?.drivingLicense?.first(where: { $0.isFront == 1})?.documentPath ?? "uploadFront")
    drivingLcenseBackImageView.setImage(with: data?.drivingLicense?.first(where: { $0.isFront == 0})?.documentPath ?? "uplaodBack")
      
    vehicleInsuranceImageView.setImage(with: data?.vehicleInsurance?.first?.documentPath ?? "uploadFront")
    
    pollutionPaperImageView.setOrPlaceholderImage(
      path: data?.pollutionPaper?.first?.documentPath,
        placeholder: "uploadFront"
    )
    let registrationURL = data?.registrationCertificate?.first(where: { $0.isFront == 1})?.documentPath ?? ""
    registrtionCertificateView.isHidden = registrationURL.isEmpty
    registrationCertificationFrontImagViw.setOrPlaceholderImage(
      path: data?.registrationCertificate?.first(where: { $0.isFront == 1 })?.documentPath,
        placeholder: "uploadFront"
    )

    registrationCertificationBackImagViw.setOrPlaceholderImage(
      path: data?.registrationCertificate?.first(where: { $0.isFront == 0 })?.documentPath,
        placeholder: "uplaodBack"
    )
  }
  
}
