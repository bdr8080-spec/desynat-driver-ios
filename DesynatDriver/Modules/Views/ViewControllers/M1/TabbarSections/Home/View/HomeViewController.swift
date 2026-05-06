//
//  HomeViewController.swift
//  DesynatUser
//
//  Created by Rakhi Kumari on 23/10/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var notificationcountLabel: UILabel!
    @IBOutlet weak var notificationCountView: CustomView!
    @IBOutlet weak var busyOnOffLabel: UILabel!
    @IBOutlet weak var btnToggle: UIButton!
    @IBOutlet weak var txtFromDate: UITextField!
    @IBOutlet weak var txtToDate: UITextField!
    @IBOutlet weak var imgRadioToday: UIImageView!
    @IBOutlet weak var imgRadioThisWeek: UIImageView!
    @IBOutlet weak var imgRadioThisMonth: UIImageView!
    @IBOutlet weak var lblNewDeliveries: UILabel!
    @IBOutlet weak var lblOnGoingDeliveries: UILabel!
    @IBOutlet weak var lblTotalDeliveries: UILabel!
    @IBOutlet weak var newDeliveriesCollectionView: UICollectionView!
    @IBOutlet weak var ongoingCollectionView: UICollectionView!
    @IBOutlet weak var noDeliveryFoundLabel: UILabel!
    @IBOutlet weak var noOngingDataFoundLabel: UILabel!
    
    private lazy var viewModel = HomeViewModel(hostVC: self)
    var activeTextField: UITextField?
    var viewDate = UIDatePicker()
    var timeStamp = Double()
    var date = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDate()
        setDelegates()
        viewModel.getDelearProfile()
        setupCollectionViewLayouts()
        viewModel.onHomeDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.newDeliveriesCollectionView.reloadData()
                self?.ongoingCollectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getHomeData()
        viewModel.getCountOfNotificationRequest()
    }
    
    @IBAction func btnTapSideMenu(_ sender: Any) {
        let vc = SideMenuViewController.instantiate(fromAppStoryboard: .SideMenu)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func btnTapToggle(_ sender: UIButton) {
        viewModel.statusUpdateAPI { [weak self] success in
            guard let self = self else { return }
            if success {
                if let status = viewModel.storeAvailabilityModel?.onDuty {
                    if status == 1 {
                        busyOnOffLabel.text = "On Duty".localiz()
                        btnToggle.setImage(UIImage(named: "toggle"), for: .normal)
                        CommonUtils.showToast(message: "Duty on succesfully ".localiz())
                    } else {
                        busyOnOffLabel.text = "Off Duty".localiz()
                        btnToggle.setImage(UIImage(named: "toggle_off"), for: .normal)
                        CommonUtils.showToast(message: "Duty off succesfully ".localiz())
                    }
                }
            }
        }
    }
    
    @IBAction func btnTapBell(_ sender: UIButton) {
        let nextVC = NotificationListViewController.instantiate(fromAppStoryboard: .Deliveries)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func btnTapToday(_ sender: UIButton) {
        let tag = sender.tag
        
        if tag == 0{
            imgRadioToday.image = UIImage(named:"active_radio")
            imgRadioThisWeek.image = UIImage(named:"inactive_radio")
            imgRadioThisMonth.image = UIImage(named:"inactive_radio")
        }else if tag == 1{
            imgRadioThisWeek.image = UIImage(named:"active_radio")
            imgRadioToday.image = UIImage(named:"inactive_radio")
            imgRadioThisMonth.image = UIImage(named:"inactive_radio")
        }else{
            imgRadioThisMonth.image = UIImage(named:"active_radio")
            imgRadioThisWeek.image = UIImage(named:"inactive_radio")
            imgRadioToday.image = UIImage(named:"inactive_radio")
        }
    }
    
    @IBAction func btnTapNewDeliveries(_ sender: Any) {
    }
    
    @IBAction func btnTapOnGoingDeliveries(_ sender: Any) {
    }
    
    @IBAction func btnTapTotalDeliveries(_ sender: UIButton) {
    }
    
    @IBAction func btnActionNewDeliveries(_ sender: UIButton) {
        NotificationCenter.default.post(
            name: .switchToDeliveriesTab,
            object: nil,
            userInfo: ["tab": DeliveriesTab.new]
        )
    }
    
    @IBAction func btnActionGoingDeliveries(_ sender: UIButton) {
        NotificationCenter.default.post(
            name: .switchToDeliveriesTab,
            object: nil,
            userInfo: ["tab": DeliveriesTab.ongoing]
        )
    }
    
    @IBAction func chatBotDidTapped(_ sender: Any) {
        let nextVC = SystemSupportChatViewController.instantiate(fromAppStoryboard: .SideMenu)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func setDelegates(){
        newDeliveriesCollectionView.delegate = self
        newDeliveriesCollectionView.dataSource = self
        newDeliveriesCollectionView.register(UINib(nibName:"DeliveryCVC", bundle:nil), forCellWithReuseIdentifier:"DeliveryCVC")
        
        ongoingCollectionView.delegate = self
        ongoingCollectionView.dataSource = self
        ongoingCollectionView.register(UINib(nibName:"DeliveryCVC", bundle:nil), forCellWithReuseIdentifier:"DeliveryCVC")
    }
    
    func setupCollectionViewLayouts() {
        let newLayout = UICollectionViewFlowLayout()
        newLayout.scrollDirection = .horizontal
        newLayout.minimumLineSpacing = 12
        newLayout.minimumInteritemSpacing = 12
        newLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        newDeliveriesCollectionView.collectionViewLayout = newLayout
        newDeliveriesCollectionView.showsHorizontalScrollIndicator = false
        
        let ongoingLayout = UICollectionViewFlowLayout()
        ongoingLayout.scrollDirection = .horizontal
        ongoingLayout.minimumLineSpacing = 12
        ongoingLayout.minimumInteritemSpacing = 12
        ongoingLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        ongoingCollectionView.collectionViewLayout = ongoingLayout
        ongoingCollectionView.showsHorizontalScrollIndicator = false
    }
    
    
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == newDeliveriesCollectionView {
            return viewModel.newOrders.count
        } else {
            return viewModel.ongoingOrders.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "DeliveryCVC",
            for: indexPath
        ) as! DeliveryCVC
        
        if collectionView == newDeliveriesCollectionView {
            let data = viewModel.newOrders[indexPath.row]
            cell.configureNewDelivery(data: data)
            
            cell.btnCall.tag = indexPath.row
            cell.btnCall.accessibilityIdentifier = "new".localiz()
        } else {
            let data = viewModel.ongoingOrders[indexPath.row]
            cell.configureOngoingDelivery(data: data)
            
            cell.btnCall.tag = indexPath.row
            cell.btnCall.accessibilityIdentifier = "ongoing".localiz()
        }
        
        cell.btnCall.addTarget(self,
                               action: #selector(call(_:)),
                               for: .touchUpInside)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(
            width: (collectionView.frame.width ) / 1,
            height: 100
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == newDeliveriesCollectionView {
            let storyboard = UIStoryboard(name: "Deliveries", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "NewDeliveryVC") as! NewDeliveryVC
            let data = viewModel.newOrders[indexPath.row]
            nextVC.orderId = self.viewModel.newOrders[indexPath.row].id ?? 0
            let returnStatus = data.returnType ?? ""
            let reEXchnageOrder = data.pOrderdetailsId ?? "0"
            if returnStatus == "0"{
                nextVC.comingReason = .newNormalOrder
                if reEXchnageOrder != "0" {
                    nextVC.comingReason = .forExchangeOrder
                }
            } else {
                if data.deliveryStatus == "1" || data.deliveryStatus == "7"{
                    if returnStatus == "1" {
                        nextVC.comingReason = .forReturnOrder
                    } else if returnStatus == "2" {
                        nextVC.comingReason = .forExchangeOrder
                    } else if returnStatus == "0" {
                        nextVC.comingReason = .forExchangeOrder
                    }
                }
            }
            navigationController?.pushViewController(nextVC, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Deliveries", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "NewDeliveryVC") as! NewDeliveryVC
            let data = viewModel.ongoingOrders[indexPath.row]
            nextVC.orderId = self.viewModel.ongoingOrders[indexPath.row].id ?? 0
            let returnStatus = data.returnType ?? ""
            let reEXchnageOrder = data.pOrderdetailsId ?? "0"
            if returnStatus == "0"{
                nextVC.comingReason = .newNormalOrder
                if reEXchnageOrder != "0" {
                    nextVC.comingReason = .forExchangeOrder
                }
            } else {
                if data.deliveryStatus == "1" || data.deliveryStatus == "7"{
                    if returnStatus == "1" {
                        nextVC.comingReason = .forReturnOrder
                    } else if returnStatus == "2" {
                        nextVC.comingReason = .forExchangeOrder
                    }
                }
            }
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    
    @objc func call(_ sender: UIButton) {
        
        let index = sender.tag
        var mobileNumber: String?
        
        if sender.accessibilityIdentifier == "new".localiz() {
            mobileNumber = viewModel.newOrders[index].productDetails?.sellerDetails?.storeInfo?.storePhone ?? ""
        } else {
            mobileNumber = viewModel.ongoingOrders[index].productDetails?.sellerDetails?.storeInfo?.storePhone ?? ""
        }
        
        guard let number = mobileNumber,
              let url = URL(string: "tel://\(number)") else { return }
        
        UIApplication.shared.open(url)
    }
    
}



extension HomeViewController:UITextFieldDelegate {
    func setDate(){
        if #available(iOS 13.4, *) {
            viewDate.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            viewDate.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            viewDate.preferredDatePickerStyle = .wheels
            viewDate.preferredDatePickerStyle = .wheels
        }
        txtToDate.delegate = self
        txtFromDate.delegate = self
        self.viewDate.datePickerMode = .date
        let currentDate = Date()
        var dateComponents = DateComponents()
        let calendar = Calendar.init(identifier: .gregorian)
        dateComponents.year = -100
        let minDate = calendar.date(byAdding: dateComponents, to: currentDate)
        dateComponents.year = 0
        let maxDate = calendar.date(byAdding: dateComponents, to: currentDate)
        viewDate.maximumDate = maxDate
        viewDate.minimumDate = minDate
        if AppLanguageManager.shared.currentLanguage == .ar {
            viewDate.locale = Locale(identifier: "ar")
            viewDate.semanticContentAttribute = .forceRightToLeft
        }else {
            viewDate.locale = Locale(identifier: "en")
            viewDate.semanticContentAttribute = .forceLeftToRight
        }
        self.txtFromDate.inputView = self.viewDate
        self.txtToDate.inputView = self.viewDate
        self.txtFromDate.inputAccessoryView = self.gettoolBar()
        self.txtToDate.inputAccessoryView = self.gettoolBar()
    }
    
    func gettoolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let myColor : UIColor = UIColor( red: 2/255, green: 14/255, blue:70/255, alpha: 1.0 )
        toolBar.tintColor = myColor
        toolBar.sizeToFit()
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done".localiz(), style: .plain, target: self, action: #selector(DoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel".localiz(), style: .plain, target: self, action: #selector(CancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }
    
    @objc func DoneClick() {
        self.view.endEditing(true)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        if let activeField = activeTextField {
            activeField.text = dateFormatter.string(from: self.viewDate.date)
        }
        
        self.timeStamp = (self.viewDate.date.timeIntervalSince1970)
        self.date = dateFormatter.string(from: viewDate.date)
        
    }
    
    @objc func CancelClick() {
        self.view.endEditing(true)
    }
    
    func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: Date())
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        viewDate.setDate(Date(), animated: true)
    }
}
