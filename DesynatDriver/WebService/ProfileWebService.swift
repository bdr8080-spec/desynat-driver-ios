////
////  ProfileWebService.swift
////  Sharekni
////
////  Created by Meet Goti on 02/01/24.
////
//
import Foundation
import Alamofire
import UIKit

extension WebService {
    
    func dutyStatusUpdateService(param: [String :Any], completion: @escaping (UserAvailability) -> Void) {
        CommonUtils.showHud(show: true)
        NetworkManager.shared.request(withAPI: .endpoint(.dutyOnOff), requestMethod: .post, requestParams: param,  requestModel: UserAvailability.self) { result, code in
            CommonUtils.showHud(show: false)
            self.evaluateWebServiceResponse(response: result) { response, message, error in
                guard let response = response else {
                    if let error {
                        UIApplication.shared.topViewController()?.showAlert(msg: error)
                    }
                    return
                }
                completion(response)
            }
        }
    }
    
    func getCountOfNotificationForService(completion:@escaping (_ user: Int)-> Void) {
        CommonUtils.showHud(show: true)
        NetworkManager.shared.request(withAPI: .endpoint(.countOfNotifcationForAffilated), requestMethod: .get,requestModel: Int.self) { result, code in
            
            CommonUtils.showHud(show: false)
            self.evaluateWebServiceResponse(response: result) { response, message,error in
                guard let user = response else {
                    if let error {
                        UIApplication.shared.topViewController()?.showAlert(msg: error)
                    }
                    return
                }
                completion(user)
            }
        }
    }
    
    func getProfile(completion: @escaping (UserProfileData) -> Void) {
        CommonUtils.showHud(show: true)
        NetworkManager.shared.request(withAPI: .endpoint(.getProfile), requestMethod: .get, requestModel: UserProfileData.self) { result, code in
            CommonUtils.showHud(show: false)
            self.evaluateWebServiceResponse(response: result) { response, message, error in
                guard let response = response else {
                    if let error {
                        UIApplication.shared.topViewController()?.showAlert(msg: error)
                    }
                    return
                }
                completion(response)
            }
        }
    }
    
    func uploadFile(withParams file:MultipartUpload,
                    completion:@escaping (_ url:String, _ msg:String?, _ code:HTTPStatusCode?)-> Void) {
        CommonUtils.showHud(show: true)
        NetworkManager.shared.requestMultiPart(url: .endpoint(.uploadImage), assets: [file], model: UploadFileDataModel.self) { result, code in
            CommonUtils.showHud(show: false)
            self.evaluateWebServiceResponse(response: result) { response, message, error in
                if let url = response?.url {
                    completion(url, message, code)
                } else if let error {
                    UIApplication.shared.topViewController()?.showAlert(msg: error)
                }
            }
        }
    }
    
    func getAllZone(completion: @escaping([DriverZoneList]) -> Void) {
        CommonUtils.showHud(show: true)
        NetworkManager.shared.request(withAPI: .endpoint(.getZoneListOfDriver), requestMethod: .get, requestModel: [DriverZoneList].self) { result, code in
            CommonUtils.showHud(show: false)
            self.evaluateWebServiceResponse(response: result) { response, message, error in
                guard let response = response else {
                    if let error {
                        UIApplication.shared.topViewController()?.showAlert(msg: error)
                    }
                    return
                }
                completion(response)
            }
        }
    }
    
    func editDriverDetails(param: [String:Any], completion: @escaping(EmptyModel) -> Void) {
        CommonUtils.showHud(show: true)
        NetworkManager.shared.request(withAPI: .endpoint(.editDriverDetails), requestMethod: .post, requestParams: param, requestModel: EmptyModel.self) { result, code in
            CommonUtils.showHud(show: false)
            self.evaluateWebServiceResponse(response: result) { response, message, error in
                guard let response = response else {
                    if let error {
                        UIApplication.shared.topViewController()?.showAlert(msg: error)
                    }
                    return
                }
                completion(response)
            }
        }
    }
    
    func deleteAccountService(completion:@escaping (_ user: EmptyModel)-> Void) {
        CommonUtils.showHud(show: true)
        NetworkManager.shared.request(withAPI:.endpoint(.deleteAccount), requestMethod: .post, requestModel: EmptyModel.self) { result, code in
            CommonUtils.showHud(show: false)
            self.evaluateWebServiceResponse(response: result) { response, message,error in
                guard let user = response else {
                    if let error {
                        UIApplication.shared.topViewController()?.showAlert(msg: error)
                    }
                    return
                }
                CommonUtils.showToast(message: message ?? "")
                completion(user)
            }
        }
    }
    
    
}
