//
//  JSONData.swift
//  JSONParser
//
//  Created by Elena on 24/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum JSONType {
    case string(String)
    case int(Int)
    case bool(Bool)
    case object(ParserObject)
    case array(ParserArray)
    
    var typeName: String {
        switch self {
        case .string:
            return "문자열"
        case .int:
            return "숫자"
        case .bool:
            return "부울"
        case .object:
            return "객체"
        case .array:
            return "배열"
        }
    }
}
protocol JSONDataForm {
    var typeName: String { get }
    var totalCount: Int { get }
    func printType() -> [String: Int]
}
