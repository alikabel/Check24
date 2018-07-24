//
//  ProdutctsAPI.swift
//  Check24Task
//
//  Created by Ali Kabel on 24.07.18.
//  Copyright © 2018 Ali Kabel. All rights reserved.
//

import Foundation
import SwiftTask

class ProdutctsAPI: APIClient {
    let url = "http://app.check24.de/products-test.json"
    
    static func getProducts() -> Task<Progress, JSONParsing, NSError> {
        let url = URL(string: "http://app.check24.de/products-test.json")!
        return self.requestAPI(.get, url: url)
    }
    
    
    
}
