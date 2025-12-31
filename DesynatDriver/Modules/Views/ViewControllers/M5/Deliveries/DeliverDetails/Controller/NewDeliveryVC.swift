//
//  NewDeliveryVC.swift
//  DesynatDriver
//
//  Created by  shailendra singh on 19/12/25.
//

import UIKit
import CoreLocation
import GoogleMaps
import MapKit
import Cosmos

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
  @IBOutlet weak var ratingView: CosmosView!
  @IBOutlet weak var storeRatingStackView: UIStackView!
  @IBOutlet weak var updateStatusButtonOutlet: CustomButton!
  @IBOutlet weak var updateStatusLabel: UILabel!
  
  
  //MARK: VARIABLES
  let viewModel = DeliveriesViewModel()
  var orderDetail : DeliveryList?
  var orderId:Int?
  var latitude:Double?
  var longitude:Double?
  let ZOOM_LEVEL_HIGH:Float = 6.0
  var currentLatLong = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
  var currentLocation:String?
  var locationManager = CLLocationManager()
  var mobileNumber: String? = ""
  
  //MARK: VIEW LIFE CYCLE
  override func viewDidLoad() {
    super.viewDidLoad()
    self.googleMapSetup()
    setData()
    updateStatusButtonOutlet.setImage(UIImage(named: "grayBackGorunf"), for: .normal)
    updateStatusLabel.textColor = UIColor.init(hexString: "#808080")
    updateStatusButtonOutlet.isEnabled = false
  }
  
  func googleMapSetup() {
    self.latitude = LocationManager.sharedInstance.location?.latitude ?? 0.0
    self.longitude = LocationManager.sharedInstance.location?.longitude ?? 0.0
    self.currentLocation =  LocationManager.sharedInstance.currentLocation
    mapVew.isMyLocationEnabled = false   // Optional: shows blue dot
//    let camera = GMSCameraPosition.camera(
//      withLatitude: latitude ?? 0.0,
//      longitude: longitude ?? 0.0,
//      zoom: ZOOM_LEVEL_HIGH // Use high zoom
//    )
    let camera = GMSCameraPosition.camera(
      withLatitude: latitude ?? 0.0,
      longitude: longitude ?? 0.0,
      zoom: 5.0 // low/default zoom
    )
    self.mapVew.camera = camera
    self.mapVew.delegate = self
    LocationManager.sharedInstance.startUpdatingLocation()
  }
  
  
  func setData() {
    self.viewModel.getOrderDetail(orderId: self.orderId ?? 0) { [weak self] in
      self?.orderDetail = self?.viewModel.orderDetail
      self?.lblPickUpAddress.text = self?.viewModel.orderDetail?.productDetails?.sellerDetails?.storeInfo?.storeAddress ?? ""
      self?.storeNameLbl.text = self?.viewModel.orderDetail?.productDetails?.sellerDetails?.storeInfo?.storeName ?? ""
      self?.imgStore.image = .placeholder
      if let url = URL(string: self?.viewModel.orderDetail?.productDetails?.sellerDetails?.storeInfo?.storeImage ?? "") {
        self?.imgStore.sd_setImage(with: url,placeholderImage: .placeholder)
      }
      
      self?.lblDropAddress.text = self?.viewModel.orderDetail?.order?.deliveryDetails?.address ?? ""
      if self?.viewModel.orderDetail?.deliveryStatus == "3" || self?.viewModel.orderDetail?.deliveryStatus == "7" || self?.viewModel.orderDetail?.deliveryStatus == "8"{
        self?.viewPickUpLocation.isHidden = true
        self?.viewPick.isHidden = true
        self?.btnStack.isHidden = false
        self?.btnPicked.isHidden = true
        self?.storeRatingStackView.isHidden = true
        self?.imgStore.image = .userProfile
        self?.storeNameLbl.text = self?.viewModel.orderDetail?.order?.userDetails?.fullName ?? ""
        if let url = URL(string: self?.viewModel.orderDetail?.order?.userDetails?.profileImage ?? "") {
          self?.imgStore.sd_setImage(with: url,placeholderImage: .placeholder)
        }
        self?.mobileNumber = self?.viewModel.orderDetail?.order?.userDetails?.mobile
      }else {
        self?.viewPickUpLocation.isHidden = false
        self?.storeRatingStackView.isHidden = false
        self?.viewPick.isHidden = false
        self?.btnStack.isHidden = true
        self?.btnPicked.isHidden = false
        self?.mobileNumber = self?.viewModel.orderDetail?.productDetails?.sellerDetails?.storeInfo?.storePhone
      }
      
      if self?.viewModel.orderDetail?.deliveryStatus == "7" {
        self?.lblStatus.text = "Picked"
      }else if self?.viewModel.orderDetail?.deliveryStatus == "8" {
        self?.lblStatus.text = "Not delivered"
      }else if self?.viewModel.orderDetail?.deliveryStatus == "3" {
        self?.lblStatus.text = "Delivered"
      }
      
      // MARK: --- Correct Pickup and Drop Coordinates ---
      let pickupCoordinate = CLLocationCoordinate2D(
        latitude: Double(self?.viewModel.orderDetail?.productDetails?.sellerDetails?.storeInfo?.storeInfoLet ?? "0.0") ?? 0.0,
        longitude: Double(self?.viewModel.orderDetail?.productDetails?.sellerDetails?.storeInfo?.long ?? "0.0") ?? 0.0
      )
      
      let dropCoordinate = CLLocationCoordinate2D(
        latitude: Double(self?.viewModel.orderDetail?.order?.deliveryDetails?.latitude ?? "0.0") ?? 0.0,
        longitude: Double(self?.viewModel.orderDetail?.order?.deliveryDetails?.longitude ?? "0.0") ?? 0.0
      )
      
      // Draw route
      self?.drawRoute(origin: pickupCoordinate, destination: dropCoordinate)
      if self?.viewModel.orderDetail?.userRatingReviewProvide == nil {
        self?.ratingView.rating = 0
        self?.lblRating.text = "0"
      } else {
        let rating = Double(self?.viewModel.orderDetail?.userRatingReviewProvide?.storeRating ?? "") ?? 0
        self?.ratingView.rating = rating
        self?.lblRating.text = self?.viewModel.orderDetail?.userRatingReviewProvide?.storeRating ?? ""
      }
    }
  }
  
  func drawRoute(origin: CLLocationCoordinate2D,
                 destination: CLLocationCoordinate2D) {
    
    let apiKey = "AIzaSyA4L_dBeJDWuqtBT9ZOOUhjigbh6Lxi43s"
    
    let urlString =
    "https://maps.googleapis.com/maps/api/directions/json?" +
    "origin=\(origin.latitude),\(origin.longitude)" +
    "&destination=\(destination.latitude),\(destination.longitude)" +
    "&key=\(apiKey)"
    
    guard let url = URL(string: urlString) else { return }
    
    DispatchQueue.global(qos: .background).async {
      guard let data = try? Data(contentsOf: url) else { return }
      
      do {
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        let routes = json?["routes"] as? [[String: Any]]
        
        guard let route = routes?.first,
              let overviewPolyline = route["overview_polyline"] as? [String: Any],
              let points = overviewPolyline["points"] as? String else { return }
        
        let path = GMSPath(fromEncodedPath: points)
        
        DispatchQueue.main.async {
          
          // Draw polyline
          let polyline = GMSPolyline(path: path)
          polyline.strokeColor = UIColor(hex: "#00C2D1")
          polyline.strokeWidth = 5
          polyline.map = self.mapVew
          
          // Pickup Marker -> Store
          let pickupMarker = GMSMarker(position: origin)
          pickupMarker.title = "Pickup Location"
          pickupMarker.icon = UIImage(named: "ic_pickup_pin")
          pickupMarker.map = self.mapVew
          
          // Drop Marker -> User
          let dropMarker = GMSMarker(position: destination)
          dropMarker.title = "Drop Location"
          dropMarker.icon = UIImage(named: "ic_drop_pin")
          dropMarker.map = self.mapVew
          
          // ✅ Fit both markers on screen
          let bounds = GMSCoordinateBounds(coordinate: origin, coordinate: destination)
          let update = GMSCameraUpdate.fit(bounds, withPadding: 100) // padding for clarity
          self.mapVew.animate(with: update)
        }
        
      } catch {
        print("Route parsing error:", error)
      }
    }
  }
  
  
  @IBAction func backBtn(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func btnPickUpLocation(_ sender: UIButton) {
    let pickupCoordinate = CLLocationCoordinate2D(
      latitude: Double(self.viewModel.orderDetail?.order?.deliveryDetails?.latitude ?? "0.0") ?? 0.0,
      longitude: Double(self.viewModel.orderDetail?.order?.deliveryDetails?.longitude ?? "0.0") ?? 0.0
    )
    openAppleMap(
      destination: pickupCoordinate,
      placeName: "Pickup Location"
    )
  }
  
  @IBAction func btnDropLocation(_ sender: UIButton) {
    let dropCoordinate = CLLocationCoordinate2D(
      latitude: Double(self.viewModel.orderDetail?.productDetails?.sellerDetails?.storeInfo?.storeInfoLet ?? "0.0") ?? 0.0,
      longitude: Double(self.viewModel.orderDetail?.productDetails?.sellerDetails?.storeInfo?.long ?? "0.0") ?? 0.0
    )
    
    openAppleMap(
      destination: dropCoordinate,
      placeName: "Drop Location"
    )
  }
  
  @IBAction func btnActionCall(_ sender: UIButton) {
    callNumber(mobileNumber)
  }
  
  @IBAction func btnCurrentLocation(_ sender: UIButton) {

//    self.latitude = LocationManager.sharedInstance.location?.latitude ?? 0.0
//    self.longitude = LocationManager.sharedInstance.location?.longitude ?? 0.0
//    let camera = GMSCameraPosition.camera(
//      withLatitude: latitude ?? 0.0,
//      longitude: longitude ?? 0.0,
//      zoom: ZOOM_LEVEL_HIGH // Zoomed in
//    )
    self.latitude = LocationManager.sharedInstance.location?.latitude ?? 0.0
      self.longitude = LocationManager.sharedInstance.location?.longitude ?? 0.0

      let camera = GMSCameraPosition.camera(
        withLatitude: latitude ?? 0.0,
        longitude: longitude ?? 0.0,
        zoom: 14.0 // good city-level zoom
      )

    self.mapVew.animate(to: camera)
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
      vc.callBackDismiss = {
        self.navigationController?.popViewController(animated: true)
      }
      self.present(vc, animated: true)
      self.setData()
    }
  }
  
  @IBAction func btnUpdateStatus(_ sender: UIButton) {
    
    if self.viewModel.orderDetail?.deliveryStatus == "7" {
      self.viewModel.pickOrder(orderId: self.orderId ?? 0) {
        let vc = RegisterationSuccessViewController.instantiate(fromAppStoryboard: .Main)
        vc.comingReason = .orderPickedSuccessfully
        vc.callBackDismiss = {
          self.navigationController?.popViewController(animated: true)
        }
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
          vc.callBackDismiss = {
            self.navigationController?.popViewController(animated: true)
          }
          self.present(vc, animated: true)
          
          // ✅ Switch to Home tab
          NotificationCenter.default.post(name: .switchToHomeTab, object: nil)
          
        }
        
      }
      
      self.present(nextVC, animated: true)
    }else {
      let paymentMethod = viewModel.orderDetail?.order?.paymentMethod
      if paymentMethod == "3" {
        let collectVC = CollectPaymentViewController.instantiate(fromAppStoryboard: .Deliveries)
        collectVC.orderId = self.orderId ?? 0
        collectVC.amount = self.viewModel.orderDetail?.order?.totalAmount
        collectVC.deliveryStatus = self.viewModel.orderDetail?.deliveryStatus ?? ""
        collectVC.reason = "Test"
        collectVC.callBackDismiss = { [weak self] in
          guard let self = self else { return }
          let successVC = RegisterationSuccessViewController.instantiate(fromAppStoryboard: .Main)
          successVC.comingReason = .orderDeliveredSuccessfully
          successVC.callBackDismiss = {
            self.navigationController?.popViewController(animated: true)
          }
          self.present(successVC, animated: true)
        }
        self.present(collectVC, animated: true)
      } else {
        self.viewModel.updateStatus(orderId: self.orderId ?? 0, deliveryStatus: self.viewModel.orderDetail?.deliveryStatus ?? "", reason: "Test") {
          let vc = RegisterationSuccessViewController.instantiate(fromAppStoryboard: .Main)
          vc.comingReason = .orderDeliveredSuccessfully
          vc.callBackDismiss = {
            self.navigationController?.popViewController(animated: true)
          }
          self.present(vc, animated: true)
          NotificationCenter.default.post(name: .switchToHomeTab, object: nil)
        }
      }
    }
  }
  
  
  @IBAction func btnActionDropdown(_ sender: UIButton) {

    let nextVC = UpdateStatusVC.instantiate(fromAppStoryboard: .Deliveries)
    
    // Pre-select current status
    nextVC.deliveryStatus = self.viewModel.orderDetail?.deliveryStatus ?? ""
    
    // Receive selected status
    nextVC.onStatusSelected = { [weak self] status in
      guard let self = self else { return }
      
      // UI Update
      self.lblStatus.text = status.title
      self.viewModel.orderDetail?.deliveryStatus = "\(status.rawValue)"
      print("Selected Status:", status.title, status.rawValue)
      
      // ✅ Enable button only for Delivered or Not Delivered
      if status.title == "Delivered" || status.title == "Not Delivered" {
        updateStatusButtonOutlet.setImage(UIImage(named: "btnGradient"), for: .normal)
        updateStatusLabel.textColor = UIColor.white
        updateStatusButtonOutlet.isEnabled = true
      } else {
        updateStatusButtonOutlet.setImage(UIImage(named: "grayBackGorunf"), for: .normal)
        updateStatusLabel.textColor = UIColor.init(hexString: "#808080")
        updateStatusButtonOutlet.isEnabled = false
      }
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
  
  func openAppleMap(destination: CLLocationCoordinate2D, placeName: String) {
    
    let currentLocation = MKMapItem.forCurrentLocation()
    
    let destinationPlacemark = MKPlacemark(coordinate: destination)
    let destinationItem = MKMapItem(placemark: destinationPlacemark)
    destinationItem.name = placeName
    
    let options = [
      MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
    ]
    
    MKMapItem.openMaps(
      with: [currentLocation, destinationItem],
      launchOptions: options
    )
  }
  
}

extension  NewDeliveryVC:CLLocationManagerDelegate,GMSMapViewDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations.last
    let camera = GMSCameraPosition.camera(
      withLatitude: (location?.coordinate.latitude)!,
      longitude: (location?.coordinate.longitude)!,
        zoom: 14.0 // or remove entirely
      )
//    let camera = GMSCameraPosition.camera(
//      withLatitude: (location?.coordinate.latitude)!,
//      longitude: (location?.coordinate.longitude)!,
//      zoom: ZOOM_LEVEL_HIGH // Zoomed in
//    )
    self.mapVew.animate(to: camera)
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
extension UIColor {
  convenience init(hex: String) {
    var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
    
    var rgb: UInt64 = 0
    Scanner(string: hexSanitized).scanHexInt64(&rgb)
    
    self.init(
      red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgb & 0x0000FF) / 255.0,
      alpha: 1.0
    )
  }
}

