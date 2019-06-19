//
//  Token+CustomStringCovertable.swift
//  JSONParser
//
//  Created by 이동영 on 29/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

extension Token: CustomStringConvertible {
    var description: String {
        switch self{
        case .number:
            return "숫자"
        case .bool:
            return "부울"
        case .string:
            return "문자열"
        case .ws:
            return "공백"
        case .colon:
            return "콜론"
        case .comma:
            return "콤마"
        case .doubleQuotation:
            return "쌍따옴표"
        case .leftBrace:
            return "중괄호(좌)"
        case .rightBrace:
            return "중괄호(우)"
        case .leftBraket:
            return "대괄호(좌)"
        case .rightBraket:
            return "대괄호(우)"
        case .value:
            return "값"
        }
    }
}
