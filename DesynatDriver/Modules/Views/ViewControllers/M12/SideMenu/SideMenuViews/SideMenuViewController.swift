//
//  SideMenuViewController.swift
//  DesynatDriver
//
//  Created by Akshara Tomar  on 06/04/26.
//

import UIKit

class SideMenuViewController: UIViewController {

    @IBOutlet weak var Sidemenutableview: UITableView! {
        didSet {
            Sidemenutableview.registerCellFromNib(cellID: "SideMenuTableViewCell")
        }
    }
    
    private var menuTitleArray = ["Terms & Condition", "Return Policy", "About Us", "FAQ’S", "Change Language", "Cancellation Policy", "Exchange Policy", "Support", "Settings"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logoutDidTapped(_ sender: Any) {
      self.showConfirmationAlert(msg: "Are you sure you want to logout?"){ [weak self] in
          guard let self = self else { return }
          logoutAPI()
      }
    }
    
    private func logoutAPI(){
        WebService.sharedInstance.logoutService() { (response) in
            kSharedSceneDelegate.logoutUser()
        }
    }
}
extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return menuTitleArray.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell",for: indexPath) as! SideMenuTableViewCell
        cell.config(title: menuTitleArray[indexPath.row], imagName: menuTitleArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = menuTitleArray[indexPath.row]
        
        switch title {
        case "Terms & Condition":
            let vc = CMSViewController.instantiate(fromAppStoryboard: .SideMenu)
            vc.reason = .termsAndCondition
            self.navigationController?.pushViewController(vc, animated: true)
            print(title)
        case "Return Policy":
            let vc = CMSViewController.instantiate(fromAppStoryboard: .SideMenu)
            vc.reason = .ReturnPolicy
            self.navigationController?.pushViewController(vc, animated: true)
            print(title)
        case "About Us":
            let vc = CMSViewController.instantiate(fromAppStoryboard: .SideMenu)
            vc.reason = .AboutUs
            self.navigationController?.pushViewController(vc, animated: true)
            print(title)
        case "FAQ’S":
            let nextVC = FAQViewController.instantiate(fromAppStoryboard: .SideMenu)
            self.navigationController?.pushViewController(nextVC, animated: true)
            print(title)
        case "Change Language":
            let nextVC = SelectLanguageviewController.instantiate(fromAppStoryboard: .SideMenu)
            self.navigationController?.pushViewController(nextVC, animated: true)
            print(title)
        case "Cancellation Policy":
            let vc = CMSViewController.instantiate(fromAppStoryboard: .SideMenu)
            vc.reason = .CancellationPolicy
            self.navigationController?.pushViewController(vc, animated: true)
            print(title)
        case "Exchange Policy":
            let vc = CMSViewController.instantiate(fromAppStoryboard: .SideMenu)
            vc.reason = .ExchangePolicy
            self.navigationController?.pushViewController(vc, animated: true)
            print(title)
        case "Support":
            let nextVC = SupportViewController.instantiate(fromAppStoryboard: .SideMenu)
            self.navigationController?.pushViewController(nextVC, animated: true)
        case "Settings":
            let nextVC = SettingViewController.instantiate(fromAppStoryboard: .SideMenu)
            self.navigationController?.pushViewController(nextVC, animated: true)
        default:
            break
        }
    }
}
