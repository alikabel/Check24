//
//  Price.swift
//  Check24Task
//
//  Created by Ali Kabel on 24.07.18.
//  Copyright © 2018 Ali Kabel. All rights reserved.
//

import Foundation
import SwiftyJSON

class Price: NSObject, JSONMappable {
    
    let value: Float
    let currency: String
    
    
    init(
        value: Float,
        currency: String
        ) {
        self.value = value
        self.currency = currency
    }
    
    // MARK: - JSONMappable
    typealias T = Price
    static func mapJSON(_ json: SwiftyJSON.JSON) -> T {
        return Price(
            value: json["value"].floatValue,
            currency: json["currency"].stringValue
        )
    }
}
