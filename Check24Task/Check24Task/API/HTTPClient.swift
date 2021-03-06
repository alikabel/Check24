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
    
    static func request<T:JSONMappable>(_ method: Alamofire.HTTPMethod, url: URL) -> Task<Progress, T, NSError> {
        return Task<Progress, T, NSError> { progress, fulfill, reject, configure in
            self.manager?
                .request(url, method: method)
                .validate(statusCode: 200..<300)
                .responseJSON(completionHandler: {response -> Void in
                    switch response.result {
                    case .success(let value):
                        if let json = JSON(rawValue: value) {
                            fulfill(T.mapJSON(json[]) as! T)
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
                        
                        reject(error as NSError)
                        return
                    }
                })
        }
    }
}

