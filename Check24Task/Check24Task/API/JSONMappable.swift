//
//  JSONMappable.swift
//  Check24Task
//
//  Created by Ali Kabel on 23.07.18.
//  Copyright © 2018 Ali Kabel. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONMappable{
    associatedtype T
    static func mapJSON(_ json: SwiftyJSON.JSON) -> T
}
