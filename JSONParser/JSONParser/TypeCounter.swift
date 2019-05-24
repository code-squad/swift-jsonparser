//
//  TypeCounter.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TypeCounter {
    static func getTotalTypeCount(of value: JSONValue & TypeCountable) -> [String : Int] {
        let elements = value.elements
        var typeCount = [String : Int]()
        for element in elements {
            typeCount[element.typeDescription, default: 0] += 1
        }
        return typeCount
    }
}
