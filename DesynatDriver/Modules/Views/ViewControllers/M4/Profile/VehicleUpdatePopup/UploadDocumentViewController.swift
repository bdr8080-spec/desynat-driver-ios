//
//  UploadDocumentViewController.swift
//  DesynatDriver
//
//  Created by fluper on 04/12/25.
//

import UIKit

class UploadDocumentViewController: UIViewController {
  
  @IBOutlet weak var driverDocumentBackImageView: CustomImageView!
  @IBOutlet weak var driverDocumentFrontImageView: CustomImageView!
  @IBOutlet weak var headerView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var backView: UIView!
  @IBOutlet weak var frontView: UIView!
  
  var comingReason: ComingReasonUploadDocument = .vehicleImage
  var driverDocuments: [DrivingLicense]?
  var driverDocumnetFrontImageUrl: String? = ""
  var driverDocumnetBackImageUrl: String? = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initialSetup()
  }
  
  @IBAction func crossDidTapped(_ sender: Any) {
    self.dismiss(animated: true)
  }
  
  @IBAction func updateDidTapped(_ sender: Any) {
    if validateFields() {
      editDriverProfileApi()
    }
  }
  
  @IBAction func uploadFronDidTapped(_ sender: Any) {
    let picker = ImagePickerManager.shared
    picker.allowPDFSelection = true
    picker.pickImage(self) { [weak self] image, fileName, url in
      guard let self = self else { return }
      if let url = url, url.pathExtension.lowercased() == "pdf" {
        DispatchQueue.main.async {
          self.driverDocumentFrontImageView.image = UIImage(named: "pdf_uploaded_sec")
        }
        // Upload PDF as Data
        if let pdfData = try? Data(contentsOf: url) {
          self.uploadDocument(file: pdfData, isImage: false) { uploadedUrl in
            DispatchQueue.main.async {
              self.driverDocumnetFrontImageUrl = uploadedUrl
            }
          }
        }
      } else {
        // Handle image
        DispatchQueue.main.async {
          self.driverDocumentFrontImageView.image = image
        }
        
        if let compressedData = image.jpegData(compressionQuality: 0.25),
           let finalImage = UIImage(data: compressedData) {
          self.uploadDocument(file: finalImage, isImage: true) { uploadedUrl in
            DispatchQueue.main.async {
              self.driverDocumnetFrontImageUrl = uploadedUrl
            }
          }
        }
      }
    }
  }
  
  @IBAction func uploadBackDidTapped(_ sender: Any) {
    let picker = ImagePickerManager.shared
    picker.allowPDFSelection = true  // Enable PDF selection
    
    picker.pickImage(self) { [weak self] image, fileName, url in
      guard let self = self else { return }
      
      // Check if the picked file is a PDF
      if let url = url, url.pathExtension.lowercased() == "pdf" {
        DispatchQueue.main.async {
          self.driverDocumentBackImageView.image = UIImage(named: "pdf_uploaded_sec")
        }
        // Upload PDF as Data
        if let pdfData = try? Data(contentsOf: url) {
          self.uploadDocument(file: pdfData, isImage: false) { uploadedUrl in
            DispatchQueue.main.async {
              self.driverDocumnetBackImageUrl = uploadedUrl
            }
          }
        }
      } else {
        // Handle image
        DispatchQueue.main.async {
          self.driverDocumentBackImageView.image = image
        }
        
        if let compressedData = image.jpegData(compressionQuality: 0.25),
           let finalImage = UIImage(data: compressedData) {
          self.uploadDocument(file: finalImage, isImage: true) { uploadedUrl in
            DispatchQueue.main.async {
              self.driverDocumnetBackImageUrl = uploadedUrl
            }
          }
        }
      }
    }
  }
  
  func initialSetup() {
    headerView.layer.cornerRadius = 32
    headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    headerView.clipsToBounds = true
    switch comingReason {
    case .vehicleImage:
      titleLabel.text = "Vehicle Images"
      backView.isHidden = false
      driverDocumentFrontImageView.setImage(with: driverDocuments?.first(where: { $0.isFront == 1})?.documentPath ?? "uploadFront")
      driverDocumentBackImageView.setImage(with: driverDocuments?.first(where: { $0.isFront == 0})?.documentPath ?? "uplaodBack")
      driverDocumnetFrontImageUrl = driverDocuments?.first(where: { $0.isFront == 1})?.documentPath ?? ""
      driverDocumnetBackImageUrl = driverDocuments?.first(where: { $0.isFront == 0})?.documentPath ?? ""
    case .identityProof:
      titleLabel.text = "Identity proof"
      backView.isHidden = false
      driverDocumentFrontImageView.setImage(with: driverDocuments?.first(where: { $0.isFront == 1})?.documentPath ?? "uploadFront")
      driverDocumentBackImageView.setImage(with: driverDocuments?.first(where: { $0.isFront == 0})?.documentPath ?? "uplaodBack")
      driverDocumnetFrontImageUrl = driverDocuments?.first(where: { $0.isFront == 1})?.documentPath ?? ""
      driverDocumnetBackImageUrl = driverDocuments?.first(where: { $0.isFront == 0})?.documentPath ?? ""
    case .drivingLicence:
      titleLabel.text = "Driving license"
      backView.isHidden = false
      driverDocumentFrontImageView.setImage(with: driverDocuments?.first(where: { $0.isFront == 1})?.documentPath ?? "uploadFront")
      driverDocumentBackImageView.setImage(with: driverDocuments?.first(where: { $0.isFront == 0})?.documentPath ?? "uplaodBack")
      driverDocumnetFrontImageUrl = driverDocuments?.first(where: { $0.isFront == 1})?.documentPath ?? ""
      driverDocumnetBackImageUrl = driverDocuments?.first(where: { $0.isFront == 0})?.documentPath ?? ""
    case .vehcileInsurance:
      titleLabel.text = "Vehicle insurance"
      backView.isHidden = true
      driverDocumentFrontImageView.setImage(with: driverDocuments?.first?.documentPath ?? "uploadFront")
      driverDocumnetFrontImageUrl = driverDocuments?.first?.documentPath ?? ""
    case .pollutionPaper:
      titleLabel.text = "Pollution paper"
      backView.isHidden = true
      driverDocumentFrontImageView.setOrPlaceholderImage(
        path: driverDocuments?.first?.documentPath,
        placeholder: "uploadFront"
      )
      driverDocumnetFrontImageUrl = driverDocuments?.first?.documentPath ?? ""
    case .registrationCertificate:
      titleLabel.text = "Registration Certificate"
      backView.isHidden = false
      driverDocumentFrontImageView.setImage(with: driverDocuments?.first(where: { $0.isFront == 1})?.documentPath ?? "uploadFront")
      driverDocumentBackImageView.setImage(with: driverDocuments?.first(where: { $0.isFront == 0})?.documentPath ?? "uplaodBack")
      driverDocumnetFrontImageUrl = driverDocuments?.first(where: { $0.isFront == 1})?.documentPath ?? ""
      driverDocumnetBackImageUrl = driverDocuments?.first(where: { $0.isFront == 0})?.documentPath ?? ""
    }
  }
  
}

extension UploadDocumentViewController {
  
  func uploadDocument(file: Any, isImage: Bool, completion: @escaping(String) -> Void) {
    let param:MultipartUpload = MultipartUpload(fileName: "image", file: file, mimeType: isImage ? .image : .pdf)
    WebService.sharedInstance.uploadFile(withParams: param) { url, msg, code in
      completion(url)
    }
  }
  
  func editDriverProfileApi() {
    var params: [String: Any] = ["delivery_boy_id":  driverProfileData?.id ?? 0]
    switch comingReason {
    case .vehicleImage:
      params["vehicle_image_front"] = driverDocumnetFrontImageUrl
      params["vehicle_image_back"] = driverDocumnetBackImageUrl
    case .identityProof:
      params["identity_proof_front"] = driverDocumnetFrontImageUrl
      params["identity_proof_back"] = driverDocumnetBackImageUrl
    case .drivingLicence:
      params["driving_license_front"] = driverDocumnetFrontImageUrl
      params["driving_license_back"] = driverDocumnetBackImageUrl
    case .vehcileInsurance:
      params["vehicle_insurance"] = driverDocumnetFrontImageUrl
    case .pollutionPaper:
      params["pollution_paper"] = driverDocumnetFrontImageUrl
    case .registrationCertificate:
      params["registration_certificate_front"] = driverDocumnetFrontImageUrl
      params["registration_certificate_back"] = driverDocumnetBackImageUrl
    }
    WebService.sharedInstance.editDriverDetails(param: params) { (response) in
      DispatchQueue.main.async { [weak self] in
        guard let self else { return }
        let nextVC = UpdateSuccessViewController.instantiate(fromAppStoryboard: .Profile)
        switch comingReason {
        case .vehicleImage:
          nextVC.comingReason = .vehicleImage
        case .identityProof:
          nextVC.comingReason = .identityProof
        case .drivingLicence:
          nextVC.comingReason = .drivingLicence
        case .vehcileInsurance:
          nextVC.comingReason = .vehcileInsurance
        case .pollutionPaper:
          nextVC.comingReason = .pollutionPaper
        case .registrationCertificate:
          nextVC.comingReason = .registrationCertificate
        }
        nextVC.callBackDismiss = {
          self.dismiss(animated: true)
        }
        self.present(nextVC, animated: true)
      }
    }
  }
  
  func validateFields() -> Bool {
    var error: AlertConstant = .none
    
    let frontImageOutput = String.getString(driverDocumnetFrontImageUrl).trimmingCharacters(in: .whitespacesAndNewlines)
    let backImageOutput = String.getString(driverDocumnetBackImageUrl).trimmingCharacters(in: .whitespacesAndNewlines)
    
    switch comingReason {
    case .vehicleImage:
      if frontImageOutput.isEmpty {
        error = .uploadVehicleFront
      } else if backImageOutput.isEmpty {
        error = .uploadVehicleBack
      }
    case .identityProof:
      if frontImageOutput.isEmpty {
        error = .uploadIdentityFront
      } else if backImageOutput.isEmpty {
        error = .uploadIdentityBack
      }
    case .drivingLicence:
      if frontImageOutput.isEmpty {
        error = .uploadDLFront
      } else if backImageOutput.isEmpty {
        error = .uploadDLBack
      }
    case .vehcileInsurance:
      if frontImageOutput.isEmpty {
        error = .uploadInsurance
      }
    case .pollutionPaper:
      print("")
    case .registrationCertificate:
      print("")
    }
    if error != .none {
      showAlert(msg: error.rawValue)
      return false
    }
    return true
  }
}

enum ComingReasonUploadDocument {
  case vehicleImage
  case identityProof
  case drivingLicence
  case vehcileInsurance
  case pollutionPaper
  case registrationCertificate
}
