//
//  SelectLanguageViewController.swift
//  DesynatUser
//
//  Created by Rakhi Kumari on 22/10/25.
//

import UIKit

class SelectLanguageViewController: UIViewController {
    
    @IBOutlet weak var arabicView: CustomView!
    @IBOutlet weak var englishView: CustomView!
    @IBOutlet weak var imgArabic: UIImageView!
    @IBOutlet weak var imgEnglish: UIImageView!
    
    var comingFirstTime: Bool = true
    private var selectedLanguage: Languages = .en
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.sharedInstance.startUpdatingLocation()
        let isOnBoardingChecked = UserDefaults.standard.string(forKey:"isOnBoardingChecked")
        if isOnBoardingChecked == "true" {
            comingFirstTime = false
        } else {
            comingFirstTime = true
        }
        selectedLanguage = AppLanguageManager.shared.currentLanguage
        selectLanguage(isEnglishSelected: selectedLanguage != .ar)
    }
    
    private func selectLanguage(isEnglishSelected: Bool) {
        englishView.layer.borderWidth = 1
        arabicView.layer.borderWidth = 1
        let selectedColor = UIColor(named: "darkBrown")?.cgColor
        let deselectedColor = UIColor.lightGray.cgColor
        englishView.layer.borderColor = isEnglishSelected ? selectedColor : deselectedColor
        imgEnglish.image = UIImage(named: isEnglishSelected ? "radioSelected" : "radioUnselected")
        arabicView.layer.borderColor = isEnglishSelected ? deselectedColor : selectedColor
        imgArabic.image = UIImage(named: isEnglishSelected ? "radioUnselected" : "radioSelected")
    }
    
    private func applyLanguageChange() {
        AppLanguageManager.shared.setLanguage(language: selectedLanguage)
        if selectedLanguage == .ar {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        refreshUI()
    }
    
    private func refreshUI() {
        let nextVC = SelectLanguageViewController.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.setViewControllers([nextVC], animated: false)
    }
    
    @IBAction func btnSelectLanguage(_ sender: UIButton) {
//        if sender.tag == 0 {
//            imgArabic.image = UIImage(named: "radioUnselected")
//            imgEnglish.image = UIImage(named: "radioSelected")
//            arabicView.layer.borderColor = UIColor.lightGray.cgColor
//            englishView.layer.borderColor = UIColor(named: "darkBrown")?.cgColor
//        } else {
//            imgArabic.image = UIImage(named: "radioSelected")
//            imgEnglish.image = UIImage(named: "radioUnselected")
//            arabicView.layer.borderColor = UIColor(named: "darkBrown")?.cgColor
//            englishView.layer.borderColor = UIColor.lightGray.cgColor
//        }
        if sender.tag == 0 {
            selectedLanguage = .en
            selectLanguage(isEnglishSelected: true)
        } else {
            selectedLanguage = .ar
            selectLanguage(isEnglishSelected: false)
        }
        applyLanguageChange()
    }
    
    @IBAction func btnTapContinue(_ sender: Any) {
        if comingFirstTime {
            let vc = WelcomeScreenViewController.instantiate(fromAppStoryboard: .Main)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            kSharedSceneDelegate.navigateToLoginVC()
        }
    }
}
