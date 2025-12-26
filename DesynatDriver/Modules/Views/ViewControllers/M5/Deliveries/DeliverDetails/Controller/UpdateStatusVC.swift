//
//  UpdateStatusVC.swift
//  DesynatDriver
//
//  Created by Chandra Prakash on 24/12/25.
//

import UIKit

class UpdateStatusVC: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var tableView: TableViewDynamicHeight!
    
    //MARK: VARIABLE
    var deliveryStatus: String?   // current status (string "7","3","8")
    var selectedIndex: Int?
    
    /// CALLBACK
    var onStatusSelected: ((DeliveryStatus) -> Void)?
    
    let orderStatusType: [DeliveryStatus] = [
        .picked,
        .delivered,
        .notDelivered
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewRegister()
        setPreSelectedIndex()
    }
    
    private func setPreSelectedIndex() {
        guard let status = Int(deliveryStatus ?? "") else { return }
        if let index = orderStatusType.firstIndex(where: { $0.rawValue == status }) {
            selectedIndex = index
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
}

extension UpdateStatusVC : UITableViewDelegate, UITableViewDataSource {
    
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

        let selectedStatus = orderStatusType[indexPath.row]

        /// PASS BACK
        onStatusSelected?(selectedStatus)

        /// CLOSE
        self.dismiss(animated: true)
    }

}
