//
//  DeliveriesVC.swift
//  DesynatDriver
//
//  Created by Mohd Faizan on 20/11/25.
//

import UIKit

class DeliveriesVC: UIViewController {

  @IBOutlet weak var deliveriesTableview: UITableView! {
    didSet {
      deliveriesTableview.registerCellFromNib(cellID: "DeliveriesListTableViewCell")
    }
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}

extension DeliveriesVC: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 6
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveriesListTableViewCell", for: indexPath) as! DeliveriesListTableViewCell
    return cell
  }
  
  
}
