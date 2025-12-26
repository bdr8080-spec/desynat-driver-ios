//
//  TabBarVC.swift
//  Altair
//
//  Created by Hari on 25/07/25.
//

import UIKit
extension Notification.Name {
    static let switchToHomeTab = Notification.Name("switchToHomeTab")
}

extension Notification.Name {
    static let switchToDeliveriesTab = Notification.Name("switchToDeliveriesTab")
}

class TabBarVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var tabButtons: [UIButton]!

    var initialTabIndex: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTabSelection(forTag: initialTabIndex)
        NotificationCenter.default.addObserver(
               self,
               selector: #selector(switchToDeliveries(_:)),
               name: .switchToDeliveriesTab,
               object: nil
           )
        NotificationCenter.default.addObserver(
                self,
                selector: #selector(switchToHome),
                name: .switchToHomeTab,
                object: nil
            )
    }
    
    @objc private func switchToDeliveries(_ notification: Notification) {

        let tab = notification.userInfo?["tab"] as? DeliveriesTab ?? .all

        // switch tabbar to Deliveries
        updateTabSelection(forTag: 1)

        // get DeliveriesVC safely
        if let deliveriesVC = children.first as? DeliveriesVC {
            deliveriesVC.initialTabFromHome = tab   // 🔥 STORE ONLY
        }
    }


    
    @objc private func switchToHome() {
        updateTabSelection(forTag: 0)
    }
    
    deinit {
            NotificationCenter.default.removeObserver(self)
            print("TabBarVC deinitialized")
        }
    
    @IBAction func tabBarAction(_ sender: UIButton) {
        updateTabSelection(forTag: sender.tag)
    }
    
    private func updateTabSelection(forTag tag: Int) {
        loadSubview(forTag: tag)
        setUserButtonImages(selectedTag: tag)
    }

    private func setUserButtonImages(selectedTag: Int) {
        let unselectedImages = ["homeUnselect", "deliveriesUnselect","profileUnselect"]
        let selectedImages = ["homeSelect", "deliveriesSelect","profileSelect"]
        
        for button in tabButtons {
            let imageName = (button.tag == selectedTag) ? selectedImages[button.tag] : unselectedImages[button.tag]
            button.setImage(UIImage(named: imageName), for: .normal)
        }
    }
}

// MARK: - Load Child VC
extension TabBarVC {
    func loadSubview(forTag tag: Int) {
        guard let containerView = containerView else { return }

        // Remove existing child view
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }

        // Load new child view controller
        let childVC: UIViewController
        switch tag {
        case 0:
            childVC = HomeViewController.instantiate(fromAppStoryboard: .Home)
        case 1:
            childVC = DeliveriesVC.instantiate(fromAppStoryboard: .Home)
          //  childVC = ProductsViewController.instantiate(fromAppStoryboard: .Home)
        case 2:
            childVC = ProfileVC.instantiate(fromAppStoryboard: .Home)
          //  childVC = ShowViewController.instantiate(fromAppStoryboard: .Home)
        default:
            return
        }

        addChild(childVC)
        childVC.view.frame = containerView.bounds
        containerView.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }
}
