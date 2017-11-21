//
//  CaseJSONDataTypePattern.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

enum CaseJSONDataTypePattern {
    case booleanType
    case numberType
    case stringType
    
    var pattern: String {
        switch self {
        case .booleanType:
            return "^false|true"
        case .numberType:
            return "^[0-9]+"
        case .stringType:
            return "^[A-Za-z0-9가-힣-+\"]+"
        }
    }
}
