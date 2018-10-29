//
//  JSONType.swift
//  JSONParser
//
//  Created by 윤지영 on 23/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol JSONData {
    var typeName: String { get }
}

extension String: JSONData {
    var typeName: String {
        return "문자열"
    }
}

extension Int: JSONData {
    var typeName: String {
        return "숫자"
    }
}

extension Bool: JSONData {
    var typeName: String {
        return "부울"
    }
}

extension Dictionary: JSONData where Key == String, Value == JSONData {
    var typeName: String {
        return "객체"
    }
}

extension Array: JSONData where Element == JSONData {
    var typeName: String {
        return "배열"
    }
}
