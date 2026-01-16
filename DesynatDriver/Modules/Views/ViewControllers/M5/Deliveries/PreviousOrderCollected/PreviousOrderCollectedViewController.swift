//
//  PreviousOrderCollectedViewController.swift
//  DesynatDriver
//
//  Created by Rakhi Kumari on 14/01/26.
//

import UIKit

class PreviousOrderCollectedViewController: UIViewController {
  
    @IBOutlet weak var customParentView: CustomView!
    @IBOutlet weak var productTableView: TableViewDynamicHeight! {
    didSet {
      productTableView.registerCellFromNib(cellID: "ProductTVC")
    }
  }
  var orderDetail : DeliveryList?
  var deliveryStatus: String? = ""
  var reason: String? = ""
  var amount: String? = ""
  var callBackDismiss: (()->())?
  
  override func viewDidLoad() {
    super.viewDidLoad()
      setupBackgroundTap()
    
  }
    
    private func setupBackgroundTap() {
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
          tapGesture.delegate = self
          tapGesture.cancelsTouchesInView = false
          view.addGestureRecognizer(tapGesture)
      }

  
  @IBAction func collectedDidTapped(_ sender: Any) {
    updateStatus()
  }
  
  func updateStatus() {
    let param: [String: Any] = [
      "id": orderDetail?.id ?? "",
      "delivery_status": "3", //deliveryStatus ?? "",
//      "reason": reason ?? "",
//      "collect_amount": 1
    ]
    
    WebService.sharedInstance.updateDeliveryStatus(parameter: param) { [weak self] _ in
      guard let self = self else { return }
      self.dismiss(animated: true) {
        self.callBackDismiss?()
      }
    }
  }
  
  
}

extension PreviousOrderCollectedViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTVC", for: indexPath) as! ProductTVC
    cell.setData(data: self.orderDetail)
    return cell
  }
}

extension PreviousOrderCollectedViewController: UIGestureRecognizerDelegate {
 
    @objc private func backgroundTapped() {
        dismiss(animated: true)
    }
 
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: customParentView) == true {
            return false
        }
        return true
    }
}
