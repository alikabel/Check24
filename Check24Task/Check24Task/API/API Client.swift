//
//  API Client.swift
//  Check24Task
//
//  Created by Ali Kabel on 23.07.18.
//  Copyright © 2018 Ali Kabel. All rights reserved.
//

import Alamofire
import SwiftTask

typealias ErrorInfo = (error: NSError?, isCancelled: Bool)

class APIClient: HTTPClient {
    
    /**
     requestAPI with params
     */
//    static func requestAPI<T:JSONMappable>(_ method: Alamofire.HTTPMethod, url: URL, params: [String:AnyObject], headers: [String:String]) -> Task<Progress, T, NSError> {
//
//        return super.request(method, url: url, params: params, headers: headers)
//
//    }
    
    /**
     requestAPI without params
     */
    static func requestAPI<T:JSONMappable>(_ method: Alamofire.HTTPMethod, url: URL) -> Task<Progress, T, NSError> {
        return super.request(method, url: url)
        
    }
}
