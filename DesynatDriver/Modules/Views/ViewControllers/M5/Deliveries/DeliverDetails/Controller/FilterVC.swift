//
//  FilterVC.swift
//  DesynatDriver
//
//  Created by  shailendra singh on 19/12/25.
//

import UIKit

enum DeliveryStatus: Int {
    case confirmed = 6
    case picked = 7
    case notDelivered = 8
    case delivered = 3

    var title: String {
        switch self {
        case .picked: return "Picked".localiz()
        case .confirmed: return "Confirmed".localiz()
        case .delivered: return "Delivered".localiz()
        case .notDelivered: return "Not Delivered".localiz()
        }
    }
}

protocol FilterVCDelegate: AnyObject {
    func didApplyFilter()
    func didClearFilter()
}



class FilterVC: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var tableView: TableViewDynamicHeight!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var btnClear: UIButton!
    
    //MARK: VARIABLE
    weak var delegate: FilterVCDelegate?
    var currentTab: DeliveriesTab = .all

    //6-confirmed 7-picked 8 not delivered 3-delivered
    let orderStatusType: [DeliveryStatus] = [
        .picked,
        .confirmed,
        .delivered,
        .notDelivered
    ]
    var selectedIndex: Int?
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewRegister()
        self.btnClear.addGradientBorder(cornerRadius: 5,direction: .topToBottom,colors: [UIColor.init(hexString: "#DFBF8F"), UIColor.init(hexString: "#6E4527")])
        if let savedStatus = UserDefaults.standard.value(forKey: currentTab.filterKey) as? Int,
           let status = DeliveryStatus(rawValue: savedStatus) {
            selectedIndex = orderStatusType.firstIndex(of: status)
        }
    }
    
    func tableViewRegister() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: "FilterTableViewCell")
    }
    
    @IBAction func crossBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnApplyFilter(_ sender: Any) {
        guard let index = selectedIndex else { return }
        let status = orderStatusType[index]
        UserDefaults.standard.set(status.rawValue,
                                  forKey: currentTab.filterKey)
        
        delegate?.didApplyFilter()
        self.dismiss(animated: true)
    }
    
    @IBAction func btnClearFilter(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: currentTab.filterKey)
        selectedIndex = nil
        
        delegate?.didClearFilter()
        self.dismiss(animated: true)
    }
}

extension FilterVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderStatusType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as! FilterTableViewCell
        let isSelected = indexPath.row == selectedIndex
        let imageName = isSelected ? "radioSelected" : "radioUnselected"
        
        cell.config(orderStatusType[indexPath.row].title, imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
}
