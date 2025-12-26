//
//  NewDeliveryVC.swift
//  DesynatDriver
//
//  Created by  shailendra singh on 19/12/25.
//

import UIKit
import CoreLocation
import GoogleMaps

class NewDeliveryVC: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var storeNameLbl: UILabel!
    @IBOutlet weak var imgStore: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblPickUpAddress: UILabel!
    @IBOutlet weak var lblDropAddress: UILabel!
    @IBOutlet weak var mapVew: GMSMapView!
    @IBOutlet weak var viewPickUpLocation: UIView!
    @IBOutlet weak var viewPick: UIView!
    @IBOutlet weak var btnStack: UIStackView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var btnPicked: UIButton!
    
    //MARK: VARIABLES
    let viewModel = DeliveriesViewModel()
    var orderDetail : DeliveryList?
    var orderId:Int?
    var latitude:Double?
    var longitude:Double?
    let ZOOM_LEVEL_HIGH:Float = 16.0
    var currentLatLong = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    var currentLocation:String?
    var locationManager = CLLocationManager()
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.googleMapSetup()
        setData()
    }
    
    func googleMapSetup() {
        self.latitude = LocationManager.sharedInstance.location?.latitude ?? 0.0
        self.longitude = LocationManager.sharedInstance.location?.longitude ?? 0.0
        self.currentLocation =  LocationManager.sharedInstance.currentLocation
        mapVew.isMyLocationEnabled = false
        let camera = GMSCameraPosition.camera(withLatitude: latitude ?? 0.0, longitude: longitude ?? 0.0, zoom: 12)
        self.mapVew.camera = camera
        self.mapVew.delegate = self
        LocationManager.sharedInstance.startUpdatingLocation()
    }
    
    func setData() {
        self.viewModel.getOrderDetail(orderId: self.orderId ?? 0) { [weak self] in
            self?.orderDetail = self?.viewModel.orderDetail
            self?.lblPickUpAddress.text = self?.viewModel.orderDetail?.orderDetails?.first?.productDetails?.sellerDetails?.storeInfo?.storeAddress ?? ""
            self?.storeNameLbl.text = self?.viewModel.orderDetail?.deliveryDetails?.name ?? ""
            self?.imgStore.image = .placeholder
            if let url = URL(string: self?.viewModel.orderDetail?.orderDetails?.first?.productDetails?.sellerDetails?.storeInfo?.storeImage ?? "") {
                self?.imgStore.sd_setImage(with: url,placeholderImage: .placeholder)
            }
            self?.lblRating.text = self?.viewModel.orderDetail?.orderDetails?.first?.productDetails?.reviewRating ?? 0.description
            self?.lblDropAddress.text = self?.viewModel.orderDetail?.deliveryDetails?.address ?? ""
            if self?.viewModel.orderDetail?.deliveryStatus == "3" || self?.viewModel.orderDetail?.deliveryStatus == "7" || self?.viewModel.orderDetail?.deliveryStatus == "8"{
                self?.viewPickUpLocation.isHidden = true
                self?.viewPick.isHidden = true
                self?.btnStack.isHidden = false
                self?.btnPicked.isHidden = true
            }else {
                self?.viewPickUpLocation.isHidden = false
                self?.viewPick.isHidden = false
                self?.btnStack.isHidden = true
                self?.btnPicked.isHidden = false
            }
            
            if self?.viewModel.orderDetail?.deliveryStatus == "7" {
                self?.lblStatus.text = "Picked"
            }else if self?.viewModel.orderDetail?.deliveryStatus == "8" {
                self?.lblStatus.text = "Not delivered"
            }else if self?.viewModel.orderDetail?.deliveryStatus == "3" {
                self?.lblStatus.text = "Delivered"
            }
        }
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPickUpLocation(_ sender: UIButton) {
        
    }
    
    @IBAction func btnDropLocation(_ sender: UIButton) {
        
    }
    
    @IBAction func btnActionCall(_ sender: UIButton) {
        let mobileNumber = self.viewModel.orderDetail?.orderDetails?.first?.productDetails?.sellerDetails?.storeInfo?.storePhone
        callNumber(mobileNumber)
    }
    
    @IBAction func btnCurrentLocation(_ sender: UIButton) {
        self.latitude = LocationManager.sharedInstance.location?.latitude ?? 0.0
        self.longitude = LocationManager.sharedInstance.location?.longitude ?? 0.0
        let camera = GMSCameraPosition.camera(withLatitude: latitude ?? 0.0, longitude: longitude ?? 0.0, zoom: 12)
        self.mapVew.camera = camera
    }
    
   
    @IBAction func packageDetails(_ sender: Any) {
        let nextVC  = PackagesDetails.instantiate(fromAppStoryboard: .Deliveries)
        nextVC.orderDetail = self.orderDetail
        self.navigationController?.present(nextVC, animated: true)
    }
    
    @IBAction func pickedOrderBtn(_ sender: Any) {
        self.viewModel.pickOrder(orderId: self.orderId ?? 0) {
            let vc = RegisterationSuccessViewController.instantiate(fromAppStoryboard: .Main)
            vc.comingReason = .orderPickedSuccessfully
            self.present(vc, animated: true)
            self.setData()
        }
    }
    
    @IBAction func btnUpdateStatus(_ sender: UIButton) {
        if self.viewModel.orderDetail?.deliveryStatus == "7" {
            self.viewModel.pickOrder(orderId: self.orderId ?? 0) {
                let vc = RegisterationSuccessViewController.instantiate(fromAppStoryboard: .Main)
                vc.comingReason = .orderPickedSuccessfully
                self.present(vc, animated: true)
                self.setData()
            }
        }else if self.viewModel.orderDetail?.deliveryStatus == "8" {
            
            let nextVC = ReasonPopUpVC.instantiate(fromAppStoryboard: .Deliveries)

            nextVC.onSubmitReason = { [weak self] reasonText in
                guard let self = self else { return }

                self.viewModel.updateStatus(
                    orderId: self.orderId ?? 0,
                    deliveryStatus: "8",
                    reason: reasonText
                ) {

                    let vc = RegisterationSuccessViewController.instantiate(fromAppStoryboard: .Main)
                    vc.comingReason = .orderStatusUpdatedasNotDelivered
                    self.present(vc, animated: true)

                    // ✅ Switch to Home tab
                    NotificationCenter.default.post(name: .switchToHomeTab, object: nil)

                }

            }

            self.present(nextVC, animated: true)
        }else {
            self.viewModel.updateStatus(orderId: self.orderId ?? 0, deliveryStatus: self.viewModel.orderDetail?.deliveryStatus ?? "", reason: "Test") {
                let vc = RegisterationSuccessViewController.instantiate(fromAppStoryboard: .Main)
                vc.comingReason = .orderDeliveredSuccessfully
                self.present(vc, animated: true)
                NotificationCenter.default.post(name: .switchToHomeTab, object: nil)
            }
        }
    }
    

    
    @IBAction func btnActionDropdown(_ sender: UIButton) {
        let nextVC = UpdateStatusVC.instantiate(fromAppStoryboard: .Deliveries)
        /// current status bhejna (for pre-selection)
        nextVC.deliveryStatus = self.viewModel.orderDetail?.deliveryStatus ?? ""
        /// receive selected status
        nextVC.onStatusSelected = { [weak self] status in
            guard let self = self else { return }
            // UI Update
            self.lblStatus.text = status.title
            // API / ViewModel Update
            self.viewModel.orderDetail?.deliveryStatus = "\(status.rawValue)"
            print("Selected Status:", status.title, status.rawValue)
        }
        self.present(nextVC, animated: true)
    }
    
    func callNumber(_ number: String?) {

        guard let phone = number,
              !phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(msg: "Mobile number not available")
            return
        }

        let cleanNumber = phone.replacingOccurrences(of: " ", with: "")
        guard let url = URL(string: "tel://\(cleanNumber)") else {
            showAlert(msg: "Invalid mobile number")
            return
        }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            showAlert(msg: "Calling not supported on this device")
        }
    }
}

extension  NewDeliveryVC:CLLocationManagerDelegate,GMSMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 12.0)
        self.mapVew?.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
}

extension NewDeliveryVC {
    
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        self.latitude = cameraPosition.target.latitude
        self.longitude = cameraPosition.target.longitude
        reverseGeocodeCoordinate(cameraPosition.target)
    }
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        currentLatLong = coordinate
        let ceo: CLGeocoder = CLGeocoder()
        let loc: CLLocation = CLLocation(latitude:coordinate.latitude, longitude: coordinate.longitude)
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
            if (error != nil) {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks! as [CLPlacemark]
            if pm.count > 0 {
                let pm = placemarks![0]
                var addressString : String = ""
                var addressGlobal : String = ""
                var addressCity : String = ""
                if pm.name != nil{
                    addressString = addressString + pm.name! + ", "
                    addressGlobal = addressGlobal + pm.name! + ", "
                }
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                    addressGlobal = addressGlobal + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                    addressGlobal = addressGlobal + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressCity = addressCity + pm.locality!
                    addressString = addressString + pm.locality! + " "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                    addressGlobal = addressGlobal + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                    addressGlobal = addressGlobal + pm.postalCode! + " "
                    // self.currentPinCode = pm.postalCode ?? ""
                }
//                self.txtFieldSearch.text = addressString
//                self.lblLocation.text = addressString
//                self.locality = pm.subLocality ?? ""
//                self.pincode = pm.postalCode ?? ""
//                self.city = pm.locality ?? ""
//                self.district = pm.subAdministrativeArea ?? ""
//                self.state = pm.administrativeArea ?? ""
            }
        })
    }
}
