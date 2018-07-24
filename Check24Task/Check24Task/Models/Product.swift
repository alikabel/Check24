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
    let longDescription: String
    let releaseDate: Double
    let available: Bool
    
    init(
        name: String,
        shortDescription: String,
        price: Price,
        rating: Float,
        longDescription: String,
        releaseDate: Double,
        available: Bool
    ) {
        self.name = name
        self.shortDescription = shortDescription
        self.price = price
        self.rating = rating
        self.longDescription = longDescription
        self.releaseDate = releaseDate
        self.available = available
        
    }
    // MARK:- Methods
    func getDate(_ timeStamp: Double) -> String{
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    // MARK: - JSONMappable
    typealias T = Product
    static func mapJSON(_ json: SwiftyJSON.JSON) -> T {
        return Product(
            name: json["name"].stringValue,
            shortDescription: json["description"].stringValue,
            price: Price.mapJSON(json["price"]),
            rating: json["rating"].floatValue,
            longDescription: json["longDescription"].stringValue,
            releaseDate: json["releaseDate"].doubleValue,
            available: json["available"].boolValue
            
            
        )
    }
    
    
}
