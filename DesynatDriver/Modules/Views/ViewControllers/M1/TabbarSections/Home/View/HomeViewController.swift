//
//  HomeViewController.swift
//  DesynatUser
//
//  Created by Rakhi Kumari on 23/10/25.
//

import UIKit

class HomeViewController: UIViewController {
  
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
  @IBOutlet weak var newDeliveriesTableView: UITableView!
  
  private lazy var viewModel = HomeViewModel(hostVC: self)
  
  var activeTextField: UITextField?
  var viewDate = UIDatePicker()
  var timeStamp = Double()
  var date = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setDelegates()
    setDate()
    viewModel.getDelearProfile()
  }
  
  func setDelegates(){
    newDeliveriesTableView.delegate = self
    newDeliveriesTableView.dataSource = self
    newDeliveriesTableView.register(UINib(nibName:"NewDeliveriesTableCell", bundle:nil), forCellReuseIdentifier:"NewDeliveriesTableCell")
  }
  
  @IBAction func btnTapSideMenu(_ sender: Any) {
  }
  
  @IBAction func btnTapToggle(_ sender: UIButton) {
    viewModel.statusUpdateAPI { [weak self] success in
      guard let self = self else { return }
      if success {
        if let status = viewModel.storeAvailabilityModel?.onDuty {
          if status == 1 {
            busyOnOffLabel.text = "On Duty"
            btnToggle.setImage(UIImage(named: "toggle"), for: .normal)
            CommonUtils.showToast(message: "Duty on succesfully ")
          } else {
            busyOnOffLabel.text = "Off Duty"
            btnToggle.setImage(UIImage(named: "toggle_off"), for: .normal)
            CommonUtils.showToast(message: "Duty off succesfully ")
          }
        }
      }
    }
  }
  
  @IBAction func btnTapBell(_ sender: UIButton) {
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
  
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = newDeliveriesTableView.dequeueReusableCell(withIdentifier:"NewDeliveriesTableCell", for:indexPath)as!NewDeliveriesTableCell
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
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
    let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DoneClick))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CancelClick))
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
