//
//  JSONDataForm.swift
//  JSONParser
//
//  Created by 윤지영 on 25/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol JSONDataForm: JSONData {
    var totalCount: Int { get }
    func countType() -> [String: Int]
}

extension Dictionary: JSONDataForm where Key == String, Value == JSONData {
    var totalCount: Int {
        return self.count
    }

    func countType() -> [String : Int] {
        var typeCount: [String: Int] = [:]
        for value in self.values {
            typeCount[value.typeName] = (typeCount[value.typeName] ?? 0) + 1
        }
        return typeCount
    }
}

extension Array: JSONDataForm where Element == JSONData {
    var totalCount: Int {
        return self.count
    }

    func countType() -> [String : Int] {
        var typeCount: [String: Int] = [:]
        for value in self {
            typeCount[value.typeName] = (typeCount[value.typeName] ?? 0) + 1
        }
        return typeCount
    }
}
