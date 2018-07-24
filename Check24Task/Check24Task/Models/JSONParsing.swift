//
//  JSONParsing.swift
//  Check24Task
//
//  Created by Ali Kabel on 24.07.18.
//  Copyright © 2018 Ali Kabel. All rights reserved.
//

import Foundation
import SwiftyJSON


class JSONParsing: NSObject, JSONMappable {

    let products: [Product]
    
    init(
        products: [Product]
        
        ) {
        self.products = products
    }
    // MARK: - JSONMappable
    typealias T = JSONParsing
    static func mapJSON(_ json: SwiftyJSON.JSON) -> T {
        return JSONParsing(
            products: json["products"].arrayValue.map(Product.mapJSON)
        )
    }
}
