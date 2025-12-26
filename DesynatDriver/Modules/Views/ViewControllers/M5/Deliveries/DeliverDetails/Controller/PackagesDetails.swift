//
//  PackagesDetails.swift
//  DesynatDriver
//
//  Created by  shailendra singh on 19/12/25.
//

import UIKit

class PackagesDetails: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var dropLocationLbl: UILabel!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var oredrDateLbl: UILabel!
    @IBOutlet weak var orderIdLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var painStatusLbl: UILabel!
    
    
    @IBOutlet weak var productTableview: TableViewDynamicHeight! {
        didSet {
            productTableview.registerCellFromNib(cellID: "ProductTVC")
        }
    }
    
    //MARK: VARIABLES
    var orderDetail : DeliveryList?

    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    
    
    func setData() {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let date = isoFormatter.date(from: orderDetail?.order?.createdAt ?? "")
        self.oredrDateLbl.text = CommonUtils.getDateStrings(from: date, format: "dd/MM/yyyy 'at' hh:mm a")
        self.dropLocationLbl.text = orderDetail?.order?.deliveryDetails?.address ?? ""
        self.customerNameLbl.text = orderDetail?.order?.deliveryDetails?.name ?? ""
        self.orderIdLbl.text = CommonUtils.lastSevenWithHash("\(orderDetail?.orderID ?? 0)")
        self.priceLbl.text = CommonUtils.formatAmount(orderDetail?.order?.totalAmount ?? "")
        if orderDetail?.paymentStatus == "1" {
            self.painStatusLbl.text = "Paid"
        }else {
            self.painStatusLbl.text = "Pending"
        }
        self.productTableview.reloadData()
    }
    
    @IBAction func crossBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PackagesDetails: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTVC", for: indexPath) as! ProductTVC
       // cell.setData(data: self.orderDetail?.orderDetails?[0])
        cell.productNameLbl.text = self.orderDetail?.productDetails?.productNameEn ?? ""
        cell.productSizeLbl.text = self.orderDetail?.variationDetails?.size?.name ?? ""
        //self.colourLabel.text = data?.variationDetails?.color?.name ?? ""
        cell.productQuantityLbl.text = self.orderDetail?.quantity?.description
        cell.productImageView.image = .placeholder
        if let url = URL(string: self.orderDetail?.variationDetails?.variantImage?.first ?? "") {
            cell.productImageView.sd_setImage(with: url,placeholderImage: .placeholder)
        }
        return cell
    }
}
