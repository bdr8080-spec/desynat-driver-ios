//
//  CollectPaymentViewController.swift
//  DesynatDriver
//
//  Created by fluper on 30/12/25.
//

import UIKit

class CollectPaymentViewController: UIViewController {
  
  @IBOutlet weak var amountLabel: UILabel!
  
    @IBOutlet weak var customParentView: CustomView!
    
  var callBackDismiss: (()->())?
  var orderId: Int? = 0
  var deliveryStatus: String? = ""
  var reason: String? = ""
  var amount: String? = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    amountLabel.text = CommonUtils.formatPriceForString(amount ?? "")
      setupBackgroundTap()
  }
  
  @IBAction func collectedDidTapped(_ sender: Any) {
    updateStatus()
  }
    
    private func setupBackgroundTap() {
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
          tapGesture.delegate = self
          tapGesture.cancelsTouchesInView = false
          view.addGestureRecognizer(tapGesture)
      }
  
  func updateStatus() {
          let param: [String: Any] = [
              "id": orderId ?? 0,
              "delivery_status": deliveryStatus ?? "",
              "reason": reason ?? "",
              "collect_amount": 1
          ]

          WebService.sharedInstance.updateDeliveryStatus(parameter: param) { [weak self] _ in
              guard let self = self else { return }

              // 1️⃣ Dismiss CollectPaymentViewController
              self.dismiss(animated: true) {
                  // 2️⃣ Notify parent after dismiss
                  self.callBackDismiss?()
              }
          }
      }
  
}

extension CollectPaymentViewController: UIGestureRecognizerDelegate {
 
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
