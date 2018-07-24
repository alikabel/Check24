//
//  Connectivity.swift
//  Check24Task
//
//  Created by Ali Kabel on 23.07.18.
//  Copyright © 2018 Ali Kabel. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
