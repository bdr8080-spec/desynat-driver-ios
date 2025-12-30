//
//  DeliveriesVC.swift
//  DesynatDriver
//
//  Created by Mohd Faizan on 20/11/25.
//

import UIKit

class DeliveriesVC: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var lblAll: UILabel!
    @IBOutlet weak var lblAllBar: UILabel!
    @IBOutlet weak var lblNew: UILabel!
    @IBOutlet weak var lblNewBar: UILabel!
    @IBOutlet weak var lblOngoing: UILabel!
    @IBOutlet weak var lblOngoingBar: UILabel!
    @IBOutlet weak var lblCompleted: UILabel!
    @IBOutlet weak var lblCompletedBar: UILabel!
    @IBOutlet weak var noDataFoundLabel: UILabel!
    @IBOutlet weak var deliveriesTableview: UITableView! {
        didSet {
            deliveriesTableview.registerCellFromNib(cellID: "DeliveriesListTableViewCell")
        }
    }
    @IBOutlet weak var txtFieldSearch: BindableTextField! {
        didSet {
            self.txtFieldSearch.bind(callback: {self.viewModel.setSearch($0)})
        }
    }
    
    //MARK: VARIABLES
    let viewModel = DeliveriesViewModel()
    var initialTabFromHome: DeliveriesTab?   
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let tab = initialTabFromHome {
            switchTab(tab)
            initialTabFromHome = nil   // reset (important)
        }
      viewModel.getData()
    }

    
    private func setupBinding() {
        viewModel.onDataUpdate = { [weak self] in
            guard let self else { return }
            self.deliveriesTableview.reloadData()
        }
        
        viewModel.onNoData = { [weak self] isEmpty in
            guard let self else { return }
            self.noDataFoundLabel.isHidden = !isEmpty
            self.deliveriesTableview.isHidden = isEmpty
        }
    }

    
    @IBAction func filterBtn(_ sender: Any) {
        let nextVC = FilterVC.instantiate(fromAppStoryboard: .Deliveries)
         nextVC.currentTab = viewModel.currentTab   // 🔥 IMPORTANT
         nextVC.delegate = self
         self.present(nextVC, animated: true)
    }
    
    
    private func switchTab(_ tab:DeliveriesTab) {
        self.lblAll.textColor = .init(hexString: tab == .all ? "#875C3A" : "#C0BBBB")
        self.lblAllBar.backgroundColor = .init(hexString: tab == .all ? "#875C3A" : "#C0BBBB")
        self.lblNew.textColor = .init(hexString: tab == .new ? "#875C3A" : "#C0BBBB")
        self.lblNewBar.backgroundColor = .init(hexString: tab == .new ? "#875C3A" : "#C0BBBB")
        self.lblOngoing.textColor = .init(hexString: tab == .ongoing ? "#875C3A" : "#C0BBBB")
        self.lblOngoingBar.backgroundColor = .init(hexString: tab == .ongoing ? "#875C3A" : "#C0BBBB")
        self.lblCompleted.textColor = .init(hexString: tab == .completed ? "#875C3A" : "#C0BBBB")
        self.lblCompletedBar.backgroundColor = .init(hexString: tab == .completed ? "#875C3A" : "#C0BBBB")
        self.txtFieldSearch.text = ""
        self.viewModel.changeTab(tab)
        viewModel.loadSavedFilter()
    }
    
    @IBAction func handleTabSwitch(_ sender: UIButton) {
        if let tab = DeliveriesTab(rawValue: sender.tag) {
            self.switchTab(tab)
        }
    }
}

extension DeliveriesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveriesListTableViewCell", for: indexPath) as! DeliveriesListTableViewCell
        cell.setData(data: self.viewModel.orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.viewModel.orders[indexPath.row]
        if data.deliveryStatus == "3" {
            let storyboard = UIStoryboard(name: "Deliveries", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "DeliveryDetailsVC") as! DeliveryDetailsVC
            nextVC.orderId = self.viewModel.orders[indexPath.row].id ?? 0
            navigationController?.pushViewController(nextVC, animated: true)
        }else {
            let storyboard = UIStoryboard(name: "Deliveries", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "NewDeliveryVC") as! NewDeliveryVC
            nextVC.orderId = self.viewModel.orders[indexPath.row].id ?? 0
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.orders.count - 1 {
            if viewModel.currentPage < viewModel.totalPage {
                viewModel.currentPage += 1
                viewModel.getData()
            }
        }
    }

}

extension DeliveriesVC: FilterVCDelegate {

    func didApplyFilter() {
        viewModel.loadSavedFilter()   // 🔥 API call yahin se hogi
    }

    func didClearFilter() {
        viewModel.loadSavedFilter()   // reset + API
    }
}
