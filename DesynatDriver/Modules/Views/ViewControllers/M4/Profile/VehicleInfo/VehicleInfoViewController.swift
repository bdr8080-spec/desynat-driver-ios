//
//  VehicleInfoViewController.swift
//  DesynatDriver
//
//  Created by fluper on 04/12/25.
//

import UIKit

class VehicleInfoViewController: UIViewController {
  
  @IBOutlet weak var registrationFrontView: CustomView!
  @IBOutlet weak var registrationbackView: CustomView!
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
//    let nextVC = UpdateVehicleViewController.instantiate(fromAppStoryboard: .Profile)
//    nextVC.comingReason = .vehicleName
//    nextVC.vehicleInfo = driverProfileData?.vehicleName
//    self.navigationController?.present(nextVC, animated: true)
  }
  
  @IBAction func registrationNumberDidTappd(_ sender: Any) {
//    let nextVC = UpdateVehicleViewController.instantiate(fromAppStoryboard: .Profile)
//    nextVC.comingReason = .updateVehicleRegistration
//    nextVC.vehicleInfo = driverProfileData?.vehicleRegNo
//    self.navigationController?.present(nextVC, animated: true)
  }
  
  @IBAction func uploadVehicleDidTapped(_ sender: UIButton) {
//    let nextVC = UploadDocumentViewController.instantiate(fromAppStoryboard: .Profile)
//    nextVC.comingReason = .vehicleImage
//    nextVC.driverDocuments = driverProfileData?.vehicleImage
//    self.navigationController?.present(nextVC, animated: true)
//    let nextVC = SizeChartViewController.instantiate(fromAppStoryboard: .Profile)
//    nextVC.comingReason = .vehicleImage
//    if sender.tag == 0 {
//      nextVC.sizeChartUrl = driverProfileData?.vehicleImage?.first(where: { $0.isFront == 1})?.documentPath
//    } else {
//      nextVC.sizeChartUrl = driverProfileData?.vehicleImage?.first(where: { $0.isFront == 0})?.documentPath
//    }
//    self.navigationController?.present(nextVC, animated: true)
    
    
    guard let documentPath = sender.tag == 0
        ? driverProfileData?.vehicleImage?.first(where: { $0.isFront == 1 })?.documentPath
        : driverProfileData?.vehicleImage?.first(where: { $0.isFront == 0 })?.documentPath
    else { return }

    if documentPath.lowercased().hasSuffix(".pdf") {
        // Open PDF
        openPDF(urlString: documentPath)
    } else {
        // Open image in SizeChartViewController
        let nextVC = SizeChartViewController.instantiate(fromAppStoryboard: .Profile)
        nextVC.comingReason = .vehicleImage
        nextVC.sizeChartUrl = documentPath
        self.navigationController?.present(nextVC, animated: true)
    }
  }
  
  @IBAction func uploadIdentityDidTapped(_ sender: UIButton) {
//    let nextVC = UploadDocumentViewController.instantiate(fromAppStoryboard: .Profile)
//    nextVC.comingReason = .identityProof
//    nextVC.driverDocuments = driverProfileData?.identityProof
//    self.navigationController?.present(nextVC, animated: true)
//    
//    
//    let nextVC = SizeChartViewController.instantiate(fromAppStoryboard: .Profile)
//    nextVC.comingReason = .identityProof
//    if sender.tag == 0 {
//      nextVC.sizeChartUrl = driverProfileData?.identityProof?.first(where: { $0.isFront == 1})?.documentPath
//    } else {
//      nextVC.sizeChartUrl = driverProfileData?.identityProof?.first(where: { $0.isFront == 0})?.documentPath
//    }
//    self.navigationController?.present(nextVC, animated: true)
    
    
    guard let documentPath = sender.tag == 0
        ? driverProfileData?.identityProof?.first(where: { $0.isFront == 1 })?.documentPath
        : driverProfileData?.identityProof?.first(where: { $0.isFront == 0 })?.documentPath
    else { return }

    if documentPath.lowercased().hasSuffix(".pdf") {
        // Open PDF
        openPDF(urlString: documentPath)
    } else {
        // Open image in SizeChartViewController
        let nextVC = SizeChartViewController.instantiate(fromAppStoryboard: .Profile)
        nextVC.comingReason = .identityProof
        nextVC.sizeChartUrl = documentPath
        self.navigationController?.present(nextVC, animated: true)
    }
  }
  
  @IBAction func drivingLicenseDidTapped(_ sender: UIButton) {
//    let nextVC = UploadDocumentViewController.instantiate(fromAppStoryboard: .Profile)
//    nextVC.comingReason = .drivingLicence
//    nextVC.driverDocuments = driverProfileData?.drivingLicense
//    self.navigationController?.present(nextVC, animated: true)
    
//    let nextVC = SizeChartViewController.instantiate(fromAppStoryboard: .Profile)
//    nextVC.comingReason = .drivingLicence
//    if sender.tag == 0 {
//      nextVC.sizeChartUrl = driverProfileData?.drivingLicense?.first(where: { $0.isFront == 1})?.documentPath
//    } else {
//      nextVC.sizeChartUrl = driverProfileData?.drivingLicense?.first(where: { $0.isFront == 0})?.documentPath
//    }
//    self.navigationController?.present(nextVC, animated: true)
    
    
    
    guard let documentPath = sender.tag == 0
        ? driverProfileData?.drivingLicense?.first(where: { $0.isFront == 1 })?.documentPath
        : driverProfileData?.drivingLicense?.first(where: { $0.isFront == 0 })?.documentPath
    else { return }

    if documentPath.lowercased().hasSuffix(".pdf") {
        // Open PDF
        openPDF(urlString: documentPath)
    } else {
        // Open image in SizeChartViewController
        let nextVC = SizeChartViewController.instantiate(fromAppStoryboard: .Profile)
        nextVC.comingReason = .drivingLicence
        nextVC.sizeChartUrl = documentPath
        self.navigationController?.present(nextVC, animated: true)
    }
  }
  
  @IBAction func vehicleInsuranceDidTapped(_ sender: Any) {
//    let nextVC = UploadDocumentViewController.instantiate(fromAppStoryboard: .Profile)
//    nextVC.comingReason = .vehcileInsurance
//    nextVC.driverDocuments = driverProfileData?.vehicleInsurance
//    self.navigationController?.present(nextVC, animated: true)
//let imageUrlString = driverProfileData?.vehicleInsurance?.first?.documentPath
//    let previewVC = ImagePreviewViewController()
//       previewVC.modalPresentationStyle = .fullScreen
//       previewVC.imageUrlString = imageUrlString
//       present(previewVC, animated: true, completion: nil)
//    let nextVC = SizeChartViewController.instantiate(fromAppStoryboard: .Profile)
//    nextVC.comingReason = .vehcileInsurance
//    nextVC.sizeChartUrl = driverProfileData?.vehicleInsurance?.first?.documentPath
//    self.navigationController?.present(nextVC, animated: true)
    
    
    
    guard let documentPath = driverProfileData?.vehicleInsurance?.first?.documentPath else { return }

    if documentPath.lowercased().hasSuffix(".pdf") {
        // Open PDF
        openPDF(urlString: documentPath)
    } else {
        // Open image in SizeChartViewController
        let nextVC = SizeChartViewController.instantiate(fromAppStoryboard: .Profile)
        nextVC.comingReason = .vehcileInsurance
        nextVC.sizeChartUrl = documentPath
        self.navigationController?.present(nextVC, animated: true)
    }
  }
  
  @IBAction func pollutionCertificateDidTapped(_ sender: Any) {
//    let nextVC = UploadDocumentViewController.instantiate(fromAppStoryboard: .Profile)
//    nextVC.comingReason = .pollutionPaper
//    nextVC.driverDocuments = driverProfileData?.pollutionPaper
//    self.navigationController?.present(nextVC, animated: true)
//    let imageUrlString = driverProfileData?.pollutionPaper?.first?.documentPath
//    let previewVC = ImagePreviewViewController()
//       previewVC.modalPresentationStyle = .fullScreen
//       previewVC.imageUrlString = imageUrlString
//       present(previewVC, animated: true, completion: nil)
//    let nextVC = SizeChartViewController.instantiate(fromAppStoryboard: .Profile)
//    nextVC.comingReason = .pollutionPaper
//    nextVC.sizeChartUrl = driverProfileData?.pollutionPaper?.first?.documentPath
//    self.navigationController?.present(nextVC, animated: true)
//    
    
    guard let documentPath = driverProfileData?.pollutionPaper?.first?.documentPath else { return }

    if documentPath.lowercased().hasSuffix(".pdf") {
        // Open PDF
        openPDF(urlString: documentPath)
    } else {
        // Open image in SizeChartViewController
        let nextVC = SizeChartViewController.instantiate(fromAppStoryboard: .Profile)
        nextVC.comingReason = .pollutionPaper
        nextVC.sizeChartUrl = documentPath
        self.navigationController?.present(nextVC, animated: true)
    }
  }
  
  @IBAction func registrationCertificateDidTapped(_ sender: UIButton) {
//    let nextVC = UploadDocumentViewController.instantiate(fromAppStoryboard: .Profile)
//    nextVC.comingReason = .registrationCertificate
//    nextVC.driverDocuments = driverProfileData?.registrationCertificate
//    self.navigationController?.present(nextVC, animated: true)
    
//    let nextVC = SizeChartViewController.instantiate(fromAppStoryboard: .Profile)
//    nextVC.comingReason = .registrationCertificate
//    if sender.tag == 0 {
//      nextVC.sizeChartUrl = driverProfileData?.registrationCertificate?.first(where: { $0.isFront == 1})?.documentPath
//    } else {
//      nextVC.sizeChartUrl = driverProfileData?.registrationCertificate?.first(where: { $0.isFront == 0})?.documentPath
//    }
//    self.navigationController?.present(nextVC, animated: true)
    
    guard let documentPath = sender.tag == 0
        ? driverProfileData?.registrationCertificate?.first(where: { $0.isFront == 1 })?.documentPath
        : driverProfileData?.registrationCertificate?.first(where: { $0.isFront == 0 })?.documentPath
    else { return }

    if documentPath.lowercased().hasSuffix(".pdf") {
        // Open PDF
        openPDF(urlString: documentPath)
    } else {
        // Open image in SizeChartViewController
        let nextVC = SizeChartViewController.instantiate(fromAppStoryboard: .Profile)
        nextVC.comingReason = .registrationCertificate
        nextVC.sizeChartUrl = documentPath
        self.navigationController?.present(nextVC, animated: true)
    }

  }
  
  func openPDF(urlString: String) {
      let pdfVC = PDFViewerViewController()
      pdfVC.pdfURLString = urlString
      self.navigationController?.present(pdfVC, animated: true)
  }

  
//  func fillDriverData(data: UserProfileData?) {
//      // MARK: - Text Fields
//    vehicleNameTF.text = data?.vehicleName
//    registrationTF.text = data?.vehicleRegNo
//      // MARK: - Show Images
//    
//    let pollutionUrl = data?.pollutionPaper?.first?.documentPath ?? ""
//    pollutionCertificateView.isHidden = pollutionUrl.isEmpty
//    vehicleImageFrontImageView.setImage(with: data?.vehicleImage?.first(where: { $0.isFront == 1})?.documentPath ?? "uploadFront")
//    vehicleImageBackImageView.setImage(with: data?.vehicleImage?.first(where: { $0.isFront == 0})?.documentPath ?? "uplaodBack")
//      
//    identityProofFrontImageView.setImage(with: data?.identityProof?.first(where: { $0.isFront == 1})?.documentPath ?? "uploadFront")
//    identityProofBackImageView.setImage(with: data?.identityProof?.first(where: { $0.isFront == 0})?.documentPath ?? "uplaodBack")
//      
//    drivingLcenseFrontImageView.setImage(with: data?.drivingLicense?.first(where: { $0.isFront == 1})?.documentPath ?? "uploadFront")
//    drivingLcenseBackImageView.setImage(with: data?.drivingLicense?.first(where: { $0.isFront == 0})?.documentPath ?? "uplaodBack")
//      
//    vehicleInsuranceImageView.setImage(with: data?.vehicleInsurance?.first?.documentPath ?? "uploadFront")
//    
//    pollutionPaperImageView.setOrPlaceholderImage(
//      path: data?.pollutionPaper?.first?.documentPath,
//        placeholder: "uploadFront"
//    )
//
//    // MARK: - Registration Certificate
//        let registrationFront = data?.registrationCertificate?.first(where: { $0.isFront == 1 })?.documentPath
//        let registrationBack = data?.registrationCertificate?.first(where: { $0.isFront == 0 })?.documentPath
//
//        registrationCertificationFrontImagViw.setOrPlaceholderImage(
//            path: registrationFront,
//            placeholder: "uploadFront"
//        )
//        registrationCertificationBackImagViw.setOrPlaceholderImage(
//            path: registrationBack,
//            placeholder: "uplaodBack"
//        )
//
//        // Show/hide front/back views individually
//        registrationCertificationFrontImagViw.isHidden = (registrationFront ?? "").isEmpty
//        registrationCertificationBackImagViw.isHidden = (registrationBack ?? "").isEmpty
//
//        // Hide parent container if **both** images are missing
//        registrtionCertificateView.isHidden = (registrationFront ?? "").isEmpty && (registrationBack ?? "").isEmpty
//  }
  
  
  func fillDriverData(data: UserProfileData?) {
      
      vehicleNameTF.text = data?.vehicleName
      registrationTF.text = data?.vehicleRegNo
    let pollutionUrl = data?.pollutionPaper?.first?.documentPath ?? ""
    pollutionCertificateView.isHidden = pollutionUrl.isEmpty
      // Vehicle Images
      vehicleImageFrontImageView.setDocumentImage(
          path: data?.vehicleImage?.first(where: { $0.isFront == 1 })?.documentPath,
          placeholder: "uploadFront"
      )
      vehicleImageBackImageView.setDocumentImage(
          path: data?.vehicleImage?.first(where: { $0.isFront == 0 })?.documentPath,
          placeholder: "uploadBack"
      )
      
      // Identity proof
      identityProofFrontImageView.setDocumentImage(
          path: data?.identityProof?.first(where: { $0.isFront == 1 })?.documentPath,
          placeholder: "uploadFront"
      )
      identityProofBackImageView.setDocumentImage(
          path: data?.identityProof?.first(where: { $0.isFront == 0 })?.documentPath,
          placeholder: "uploadBack"
      )
      
      // Driving license
      drivingLcenseFrontImageView.setDocumentImage(
          path: data?.drivingLicense?.first(where: { $0.isFront == 1 })?.documentPath,
          placeholder: "uploadFront"
      )
      drivingLcenseBackImageView.setDocumentImage(
          path: data?.drivingLicense?.first(where: { $0.isFront == 0 })?.documentPath,
          placeholder: "uploadBack"
      )
      
      // Vehicle Insurance
      vehicleInsuranceImageView.setDocumentImage(
          path: data?.vehicleInsurance?.first?.documentPath,
          placeholder: "uploadFront"
      )

      // Pollution Certificate
      pollutionPaperImageView.setDocumentImage(
          path: data?.pollutionPaper?.first?.documentPath,
          placeholder: "uploadFront"
      )
      
      // Registration Certificate
      let registrationFront = data?.registrationCertificate?.first(where: { $0.isFront == 1 })?.documentPath
      let registrationBack = data?.registrationCertificate?.first(where: { $0.isFront == 0 })?.documentPath
      
      registrationCertificationFrontImagViw.setDocumentImage(
          path: registrationFront,
          placeholder: "uploadFront"
      )
      registrationCertificationBackImagViw.setDocumentImage(
          path: registrationBack,
          placeholder: "uploadBack"
      )

      // Visibility
      registrationCertificationFrontImagViw.isHidden = (registrationFront ?? "").isEmpty
      registrationCertificationBackImagViw.isHidden = (registrationBack ?? "").isEmpty
      registrtionCertificateView.isHidden = (registrationFront ?? "").isEmpty &&
                                            (registrationBack ?? "").isEmpty
  }

  
}
