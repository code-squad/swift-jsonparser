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
typealias Object = Dictionary
extension Object: JSONDataType {
var typeDescription: String {
    return "객체"
    }
}

extension Array: JSONDataType {
    var typeDescription: String {
        return "배열"
    }
}
