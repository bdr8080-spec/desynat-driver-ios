//
//  DeliveriesVC.swift
//  DesynatDriver
//
//  Created by Mohd Faizan on 20/11/25.
//

import UIKit

class DeliveriesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
  @IBAction func btnTapLogout(_ sender: UIButton) {
    logoutApi()
  }
  
  //Mark:->LogoutApi
  func logoutApi(){
//        WebService.sharedInstance.logoutService { user in
          kSharedSceneDelegate.logoutUser()
//        }
  }
}
