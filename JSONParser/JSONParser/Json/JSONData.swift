//
//  CaseJSONDataType.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

enum JSONData {
    case null
    case bool(Bool)
    case number(Double)
    case string(String)
    case array([JSONData])
    case object([String: JSONData])
    
    var bool: Bool? {
        guard case .bool(let b) = self else {
            return nil
        }
        
        return b
    }
    
    var number: Double? {
        guard case .number(let n) = self else {
            return nil
        }
        
        return n
    }
    
    var string: String?  {
        guard case .string(let s) = self else {
            return nil
        }
        
        return s
    }
    
    var array: [JSONData]? {
        guard case .array(let a) = self else {
            return nil
        }
        
        return a
    }
    
    var object: [String: JSONData]? {
        guard case .object(let o) = self else {
            return nil
        }
        
        return o
    }
}

extension JSONData {
    enum TypeName: String {
        case bool = "부울"
        case number = "숫자"
        case string = "문자열"
        case array = "배열"
        case object = "객체"
    }
}

protocol JSONDataMaker {
    func makeJSONData() -> JSONData
}

extension JSONData: JSONDataMaker {
    func makeJSONData() -> JSONData {
        return self
    }
}

protocol JSONDataCountable {
    var arrayCount: Int { get }
    var objectCount: Int { get }
    var boolCount: Int { get }
    var numberCount: Int { get }
    var stringCount: Int { get }
}


