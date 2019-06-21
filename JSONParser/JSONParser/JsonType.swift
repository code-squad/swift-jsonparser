//
//  JsonType.swift
//  JSONParser
//
//  Created by JH on 08/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JsonType {
    var typeName: String { get }
}


extension Double: JsonType {
    var typeName: String {
        return "숫자"
    }
}

extension String: JsonType {
    var typeName: String {
        return "문자열"
    }
}


extension Bool: JsonType {
    var typeName: String {
        return "부울"
    }
}

extension Array: JsonType where Element == JsonType {
    var typeName: String {
        return "배열"
    }
}
