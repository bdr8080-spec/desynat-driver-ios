////
////  NavigationSceneExt.swift
////  ChorApp
////
////  Created by Developer on 18/12/23.
////
//
import Foundation
import UIKit                 

extension SceneDelegate {
   
    /// Initialize Application (Reset Application)
//    public func initializeApplication() {
//        navigateTo(vc: ProfileSelectionVC.instantiate(fromAppStoryboard: .Main))
//    }
    
    // Navigate to Home Vc
    public func navigateToHomeVc() {
        let vc = TabBarVC.instantiate(fromAppStoryboard: .Home)
        navigateTo(vc: vc)
    }
    
    public func navigateToSelectLanguage() {
        let vc = SelectLanguageViewController.instantiate(fromAppStoryboard:.Main)
        navigateTo(vc: vc)
    }

    // Navigate to Login Vc
      public func navigateToLoginVC() {
          navigateTo(vc: LoginViewController.instantiate(fromAppStoryboard: .Main))
      }

  // Logout current user and navigate to loginVc
    func logoutUser() {
        kSharedUserDefaults.clearAllData(except: [.deviceToken,.userLocation,.selectedLanguage,.defaultLanguge,.language])
        Global.shared.user = nil
        self.navigateToLoginVC()
        UserDefaults.standard.setValue("true", forKey: "isOnBoardingChecked")
        UserDefaults.standard.set("no", forKey: "isLogin")
    }
    
//    ///Pass custom vc to make it root controller
    public func navigateTo(vc:UIViewController) {
        let nc = UINavigationController(rootViewController: vc)
        nc.isNavigationBarHidden = true
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.window!.rootViewController = nc
        sceneDelegate.window!.makeKeyAndVisible()
    }
}
