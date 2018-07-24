//
//  HTTPClient.swift
//  Check24Task
//
//  Created by Ali Kabel on 23.07.18.
//  Copyright © 2018 Ali Kabel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftTask
import SwiftyJSON

typealias Progress = (writing: Int64, writen: Int64, total: Int64)

class HTTPClient: NSObject {
    
    // Singleton Instance
    fileprivate static var _manager: Alamofire.SessionManager?
    
    // Singleton Accessor
    static var manager: Alamofire.SessionManager? {
        if let _ = _manager {
            _manager?.session.configuration.httpAdditionalHeaders = [:]
            return _manager
        }
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [:]
        _manager = Alamofire.SessionManager(configuration: config)
        return _manager
    }
    
    static func request<T:JSONMappable>(_ method: Alamofire.HTTPMethod, url: URL, params: [String: AnyObject]?, headers: [String:String] = ["Content-Type":"application/x-www-form-urlencoded"]) -> Task<Progress, T, NSError> {
        return Task<Progress, T, NSError> { progress, fulfill, reject, configure in
            self.manager?
                .request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON(completionHandler: {response -> Void in
                    switch response.result {
                    case .success(let value):
                        if let json = JSON(rawValue: value) {
                            fulfill(T.mapJSON(json) as! T)
                            return
                        }
                        reject(NSError(domain: "", code: 1001, userInfo: [:]))
                        return
                    case .failure(var error as NSError):
                        if !Connectivity.isConnectedToInternet() {
                            error = NSError(domain: "ConnectionFailed", code: 0, userInfo:nil)
                            reject(error as NSError)
                            return
                        }
                        error = self.parseFailureResponse(response, error: error as NSError)
                        reject(error as NSError)
                        return
                    default: return
                    }
                })
        }
    }
    
    static func request<T:JSONMappable>(_ method: Alamofire.HTTPMethod, url: URL, headers: [String:String] = ["Content-Type":"application/x-www-form-urlencoded"]) -> Task<Progress, T, NSError> {
        return Task<Progress, T, NSError> { progress, fulfill, reject, configure in
            self.manager?
                .request(url, method: method, headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON(completionHandler: {response -> Void in
                    switch response.result {
                    case .success(let value):
                        if let json = JSON(rawValue: value) {
                            fulfill(T.mapJSON(json) as! T)
                            return
                        }
                        reject(NSError(domain: "", code: 1001, userInfo: [:]))
                        return
                    case .failure(var error):
                        if !Connectivity.isConnectedToInternet() {
                            error = NSError(domain: "ConnectionFailed", code: 0, userInfo:nil)
                            reject(error as NSError)
                            return
                        }
                        
                        error = self.parseFailureResponse(response, error: error as NSError)
                        reject(error as NSError)
                        return
                    }
                })
        }
    }
    
    static func parseFailureResponse(_ response: DataResponse<Any>, error: NSError) -> NSError{
        var error = error
        let jsonResponse = JSON(data: response.data!)
        var errorMessageJSON = jsonResponse["error"]["message"]
        if errorMessageJSON == JSON.null {
            errorMessageJSON = jsonResponse["message"]
        }
        let errorMessage = String(describing: errorMessageJSON)
        if response.response != nil {
            error = NSError(domain: "\(String(describing: response.result.error!.localizedDescription))", code: response.response!.statusCode, userInfo:
                ["StatusCode":response.response!.statusCode,
                 "ErrorMessage":errorMessage
                ])
            return error
        }
        return error
    }
}

