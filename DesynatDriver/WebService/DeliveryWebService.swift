//
//  DeliveryWebService.swift
//  DesynatDriver
//
//  Created by Chandra Prakash on 24/12/25.
//

import Foundation
import UIKit
import Alamofire

extension WebService {
    
    func getAllOrders(parameter:[String:Any],completion: @escaping(DeliveryListModel) -> Void) {
        CommonUtils.showHud(show: true)
        NetworkManager.shared.request(
            withAPI: .endpoint(.getAllOrders),
            requestMethod: .get,
            requestParams: parameter,
            requestModel: DeliveryListModel.self
        ) { result, code in
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
    
    func getNewOrders(parameter:[String:Any],completion: @escaping(DeliveryListModel) -> Void) {
        CommonUtils.showHud(show: true)
        NetworkManager.shared.request(
            withAPI: .endpoint(.getNewOrders),
            requestMethod: .get,
            requestParams: parameter,
            requestModel: DeliveryListModel.self
        ) { result, code in
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
    
    func getOngoingOrders(parameter:[String:Any],completion: @escaping(DeliveryListModel) -> Void) {
        CommonUtils.showHud(show: true)
        NetworkManager.shared.request(
            withAPI: .endpoint(.getOngoingOrders),
            requestMethod: .get,
            requestParams: parameter,
            requestModel: DeliveryListModel.self
        ) { result, code in
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
    
    func getCompletedOrders(parameter:[String:Any],completion: @escaping(DeliveryListModel) -> Void) {
        CommonUtils.showHud(show: true)
        NetworkManager.shared.request(
            withAPI: .endpoint(.getCompletedOrder),
            requestMethod: .get,
            requestParams: parameter,
            requestModel: DeliveryListModel.self
        ) { result, code in
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
    
    func getOrderDetail(parameter:[String:Any],completion: @escaping(DeliveryList) -> Void) {
        CommonUtils.showHud(show: true)
        NetworkManager.shared.request(
            withAPI: .endpoint(.orderDetails),
            requestMethod: .get,
            requestParams: parameter,
            requestModel: DeliveryList.self
        ) { result, code in
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
    
    func getReason(parameter:[String:Any],completion: @escaping([ReasonListModel]) -> Void) {
        CommonUtils.showHud(show: true)
        NetworkManager.shared.request(
            withAPI: .endpoint(.getReasons),
            requestMethod: .get,
            requestParams: parameter,
            requestModel: [ReasonListModel].self
        ) { result, code in
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
    
    
    func updateDeliveryStatus(parameter:[String:Any],completion: @escaping(EmptyModel) -> Void) {
        CommonUtils.showHud(show: true)
        NetworkManager.shared.request(
            withAPI: .endpoint(.updateDeliveryStatus),
            requestMethod: .post,
            requestParams: parameter,
            requestModel: EmptyModel.self
        ) { result, code in
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
    
    func returnOrderToStoreInExchangeDeliveryStatus(parameter:[String:Any],completion: @escaping(EmptyModel) -> Void) {
        CommonUtils.showHud(show: true)
        NetworkManager.shared.request(
            withAPI: .endpoint(.returnOrderToStoreInExchangeDeliveryStatus),
            requestMethod: .post,
            requestParams: parameter,
            requestModel: EmptyModel.self
        ) { result, code in
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
    
    func pickOrder(parameter:[String:Any],completion: @escaping(EmptyModel) -> Void) {
        CommonUtils.showHud(show: true)
        NetworkManager.shared.request(
            withAPI: .endpoint(.pickOrder),
            requestMethod: .post,
            requestParams: parameter,
            requestModel: EmptyModel.self
        ) { result, code in
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
    
    func getMyNotificationsListService(param: [String:Any], completion: @escaping(NotificationsListDataModel) -> Void) {
        CommonUtils.showHud(show: true)
        NetworkManager.shared.request(withAPI: .endpoint(.getMyNotificationsList),requestMethod: .get, requestParams: param, requestModel: NotificationsListDataModel.self) { result, code in
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
    
    func markReadNotificationsService(param: [String:Any], completion: @escaping(EmptyModel) -> Void) {
        CommonUtils.showHud(show: true)
        NetworkManager.shared.request(withAPI: .endpoint(.markReadNotifications),requestMethod: .post, requestParams: param, requestModel: EmptyModel.self) { result, code in
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
    
    func markAllReadNotificationsService(completion: @escaping(EmptyModel) -> Void) {
        CommonUtils.showHud(show: true)
        NetworkManager.shared.request(withAPI: .endpoint(.markAllReadNotifications),requestMethod: .post, requestModel: EmptyModel.self) { result, code in
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
}
