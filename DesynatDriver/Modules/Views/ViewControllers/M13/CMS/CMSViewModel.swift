//
//  CMSViewModel.swift
//  DesynatDriver
//
//  Created by fluper_mac3 on 17/04/26.
//

import Foundation

class CMSViewModel {
    
    private var hostVC: CMSViewController
    
    init(hostVC: CMSViewController) {
        self.hostVC = hostVC
    }
    
    func getTermsAndConditionRequest() {
        let param: [String: Any] = ["type": 3]
        WebService.sharedInstance.getTermsAndConditionService(parameter: param) { [weak self] response in
            guard let self = self else { return }
            if AppLanguageManager.shared.currentLanguage == .ar {
                CommonUtils.loadHTMLContent(response.contentArabic ?? "N/A", webView: hostVC.mainWebView)
            } else {
                CommonUtils.loadHTMLContent(response.contentEnglish ?? "N/A", webView: hostVC.mainWebView)
            }
        }
    }
    
    func getReturnPolicyRequest() {
        let param: [String: Any] = ["type": 3]
        WebService.sharedInstance.getReturnPolicyService(parameter: param) { [weak self] response in
            guard let self = self else { return }
            if AppLanguageManager.shared.currentLanguage == .ar {
                CommonUtils.loadHTMLContent(response.contentArabic ?? "N/A", webView: hostVC.mainWebView)
            } else {
                CommonUtils.loadHTMLContent(response.contentEnglish ?? "N/A", webView: hostVC.mainWebView)
            }
        }
    }
    
    func getAboutUsRequest() {
        let param: [String: Any] = ["type": 3]
        WebService.sharedInstance.getAboutUsService(parameter: param) { [weak self] response in
            guard let self = self else { return }
            if AppLanguageManager.shared.currentLanguage == .ar {
                CommonUtils.loadHTMLContent(response.contentArabic ?? "N/A", webView: hostVC.mainWebView)
            } else {
                CommonUtils.loadHTMLContent(response.contentEnglish ?? "N/A", webView: hostVC.mainWebView)
            }
        }
    }
    
    func getCancellationPolicyRequest() {
        let param: [String: Any] = ["type": 3]
        WebService.sharedInstance.getCancellationPolicyService(parameter: param) { [weak self] response in
            guard let self = self else { return }
            if AppLanguageManager.shared.currentLanguage == .ar {
                CommonUtils.loadHTMLContent(response.contentArabic ?? "N/A", webView: hostVC.mainWebView)
            } else {
                CommonUtils.loadHTMLContent(response.contentEnglish ?? "N/A", webView: hostVC.mainWebView)
            }
        }
    }
    
    func getExchangePolicyRequest() {
        let param: [String: Any] = ["type": 3]
        WebService.sharedInstance.getExchangePolicyService(parameter: param) { [weak self] response in
            guard let self = self else { return }
            if AppLanguageManager.shared.currentLanguage == .ar {
                CommonUtils.loadHTMLContent(response.contentArabic ?? "N/A", webView: hostVC.mainWebView)
            } else {
                CommonUtils.loadHTMLContent(response.contentEnglish ?? "N/A", webView: hostVC.mainWebView)
            }
        }
    }
}
