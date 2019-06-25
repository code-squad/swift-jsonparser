//
//  JSONToken.swift
//  JSONParser
//
//  Created by JieunKim on 30/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JSONDataType {
     var typeDescription: String { get }
}

extension String: JSONDataType {
     var typeDescription: String {
        return "문자열"
    }
}

typealias Number = Double
extension Number: JSONDataType {
     var typeDescription: String {
        return "숫자"
    }
}

extension Bool: JSONDataType {
     var typeDescription: String {
        return "부울"
    }
}

protocol TypeCountable {
    var dataTypes: [String: Int] { get }
}

extension Array: JSONDataType, TypeCountable where Element == JSONDataType {
    var typeDescription: String {
        return "배열"
    }
    var dataTypes: [String: Int] {
        var dataTypes = [String: Int]()
        for item in self {
        dataTypes[item.typeDescription] = (dataTypes[item.typeDescription] ?? 0) + 1
        }
        return dataTypes
    }
}

typealias Object = Dictionary
extension Object: JSONDataType, TypeCountable where Key == String, Value == JSONDataType {
    var typeDescription: String {
        return "객체"
    }
    var dataTypes: [String : Int] {
        var dataTypes = [String: Int]()
        for item in self.values {
            dataTypes[item.typeDescription] = (dataTypes[item.typeDescription] ?? 0) + 1
        }
        return dataTypes
    }
}
