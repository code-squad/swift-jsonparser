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
        switch self {
        case .Array(_):
            return "배열"
        case .Number(_):
            return "숫자"
        case .Bool(_):
            return "부울"
        case .Value(_):
            return "값"
        case .String(_):
            return "문자열"
        case .WhiteSpace:
            return "공백"
        case .Comma:
            return "콤마"
        case .DoubleQuotation:
            return "쌍따옴표"
        case .LeftBraket:
            return "대괄호(좌)"
        case .RightBraket:
            return "대괄호(우)"
        }
    }
}
