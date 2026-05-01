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
  @IBOutlet weak var lblVehicleName: UILabel!
    @IBOutlet weak var vehicleImageBackView: CustomView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblVehicleName.text = "Vehicle Name".localiz()
      fillDriverData(data: driverProfileData)
    }
  
  @IBAction func myProfileDidTapped(_ sender: Any) {
    self.navigationController?.popViewController(animated: false)
  }
  
  @IBAction func backDidTapped(_ sender: Any) {
    self.navigationController?.popViewController(animated: false)
  }
  
  @IBAction func vehcileNameDidTapped(_ sender: Any) {
  }
  
  @IBAction func registrationNumberDidTappd(_ sender: Any) {
  }
  
  @IBAction func uploadVehicleDidTapped(_ sender: UIButton) {
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
  
  func fillDriverData(data: UserProfileData?) {
      
      vehicleNameTF.text = data?.vehicleName
      registrationTF.text = data?.vehicleRegNo
    let pollutionUrl = data?.pollutionPaper?.first?.documentPath ?? ""
    pollutionCertificateView.isHidden = pollutionUrl.isEmpty
      // Vehicle Images
      vehicleImageFrontImageView.setDocumentImage(
          path: data?.vehicleImage?.first(where: { $0.isFront == 1 })?.documentPath,
          placeholder: "dashedBorder"
      )
      vehicleImageBackImageView.setDocumentImage(
          path: data?.vehicleImage?.first(where: { $0.isFront == 0 })?.documentPath,
          placeholder: "dashedBorder"
      )
      
      // Identity proof
      identityProofFrontImageView.setDocumentImage(
          path: data?.identityProof?.first(where: { $0.isFront == 1 })?.documentPath,
          placeholder: "dashedBorder" //dashedBorder
      )
      identityProofBackImageView.setDocumentImage(
          path: data?.identityProof?.first(where: { $0.isFront == 0 })?.documentPath,
          placeholder: "dashedBorder"
      )
      
      // Driving license
      drivingLcenseFrontImageView.setDocumentImage(
          path: data?.drivingLicense?.first(where: { $0.isFront == 1 })?.documentPath,
          placeholder: "dashedBorder"
      )
      drivingLcenseBackImageView.setDocumentImage(
          path: data?.drivingLicense?.first(where: { $0.isFront == 0 })?.documentPath,
          placeholder: "dashedBorder"
      )
      
      // Vehicle Insurance
      vehicleInsuranceImageView.setDocumentImage(
          path: data?.vehicleInsurance?.first?.documentPath,
          placeholder: "dashedBorder"
      )

      // Pollution Certificate
      pollutionPaperImageView.setDocumentImage(
          path: data?.pollutionPaper?.first?.documentPath,
          placeholder: "dashedBorder"
      )
      
      // Registration Certificate
      let registrationFront = data?.registrationCertificate?.first(where: { $0.isFront == 1 })?.documentPath
      let registrationBack = data?.registrationCertificate?.first(where: { $0.isFront == 0 })?.documentPath
      
      registrationCertificationFrontImagViw.setDocumentImage(
          path: registrationFront,
          placeholder: "dashedBorder"
      )
      registrationCertificationBackImagViw.setDocumentImage(
          path: registrationBack,
          placeholder: "dashedBorder"
      )

      // Visibility
      registrationCertificationFrontImagViw.isHidden = (registrationFront ?? "").isEmpty
      registrationCertificationBackImagViw.isHidden = (registrationBack ?? "").isEmpty
      registrtionCertificateView.isHidden = (registrationFront ?? "").isEmpty &&
                                            (registrationBack ?? "").isEmpty
  }

}
