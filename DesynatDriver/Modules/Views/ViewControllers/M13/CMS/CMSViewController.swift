//
//  CMSViewController.swift
//  DesynatDriver
//
//  Created by Akshara Tomar  on 07/04/26.
//

import UIKit
import WebKit

class CMSViewController: UIViewController {
    
    @IBOutlet weak var mainWebView: WKWebView!
    @IBOutlet weak var titleLble: UILabel!
    
    //Marks: Variable
    private lazy var viewModel = CMSViewModel(hostVC: self)
    var reason: ComingFrom = .termsAndCondition
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainWebView.scrollView.showsVerticalScrollIndicator = false
        initialSetup()
    }
    
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initialSetup() {
        switch reason {
        case .termsAndCondition:
            titleLble.text = "Terms & Condition"
            viewModel.getTermsAndConditionRequest()
        case .ReturnPolicy:
            titleLble.text = "Return Policy"
            viewModel.getReturnPolicyRequest()
        case .AboutUs:
            titleLble.text = "About Us"
            viewModel.getAboutUsRequest()
        case .CancellationPolicy:
            titleLble.text = "Cancellation Policy"
            viewModel.getCancellationPolicyRequest()
        case .ExchangePolicy:
            titleLble.text = "Exchange Policy"
            viewModel.getExchangePolicyRequest()
        }
    }
}

enum ComingFrom {
    case termsAndCondition
    case ReturnPolicy
    case AboutUs
    case CancellationPolicy
    case ExchangePolicy
}
