//
//  Product.swift
//  Check24Task
//
//  Created by Ali Kabel on 24.07.18.
//  Copyright © 2018 Ali Kabel. All rights reserved.
//

import Foundation
import SwiftyJSON

class Product: NSObject, JSONMappable {

    let name: String
    let shortDescription: String
    let price: Price
    let rating: Float
    
    init(
        name: String,
        shortDescription: String,
        price: Price,
        rating: Float
    ) {
        self.name = name
        self.shortDescription = shortDescription
        self.price = price
        self.rating = rating
    }
    
    // MARK: - JSONMappable
    typealias T = Product
    static func mapJSON(_ json: SwiftyJSON.JSON) -> T {
        return Product(
            name: json["name"].stringValue,
            shortDescription: json["description"].stringValue,
            price: Price.mapJSON(json["price"]),
            rating: json["rating"].floatValue
            
        )
    }
}
