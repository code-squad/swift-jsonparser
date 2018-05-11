////
////  TokenSplitUnit.swift
////  JSONParser
////
////  Created by Jung seoung Yeo on 2018. 4. 20..
////  Copyright © 2018년 JK. All rights reserved.
////
//

enum Type {
    case string(String)
    case bool(Bool)
    case number(Int)
    case object([String: Type])
    case array([Type])
    
    var string: String? {
        guard case .string(let string) = self else {
            return nil
        }
        return string
    }
    
    var bool: Bool? {
        guard case .bool(let bool) = self else {
            return nil
        }
        return bool
    }
    
    var number: Int? {
        guard case .number(let number) = self else {
            return nil
        }
        return number
    }
    
    var object: [String: Type]? {
        guard case .object(let object) = self else {
            return nil
        }
        return object
    }
    
    var array: [Type]? {
        guard case .array(let array) = self else {
            return nil
        }
        return array
    }
}
