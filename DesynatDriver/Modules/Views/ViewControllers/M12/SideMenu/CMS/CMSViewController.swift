//
//  CMSViewController.swift
//  DesynatDriver
//
//  Created by Akshara Tomar  on 07/04/26.
//

import UIKit

class CMSViewController: UIViewController {

    @IBOutlet weak var titleLble: UILabel!
    
    //Marks: Variable
    var reason: ComingFrom?
    var titleStr: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLble.text = titleStr
        initialSetup()
    }
    
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initialSetup() {
        switch reason! {
        case .termsAndCondition:
            titleLble.text = "Terms & Condition"
        case .ReturnPolicy:
            titleLble.text = "Return Policy"
        case .AboutUs:
            titleLble.text = "About Us"
        case .CancellationPolicy:
            titleLble.text = "Cancellation Policy"
        case .ExchangePolicy:
            titleLble.text = "Exchange Policy"
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
