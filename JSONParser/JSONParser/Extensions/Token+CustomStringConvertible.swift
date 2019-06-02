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
        case .List :
            return "배열"
        case .Object:
            return "객체"
        case .Number:
            return "숫자"
        case .Bool:
            return "부울"
        case .Value:
            return "값"
        case .String:
            return "문자열"
        case .Key(_):
            return "키"
        case .WhiteSpace:
            return "공백"
        case .Colon:
            return "콜론"
        case .Comma:
            return "콤마"
        case .DoubleQuotation:
            return "쌍따옴표"
        case .LeftBrace:
            return "중괄호(우)"
        case .RightBrace:
            return "중괄호(우)"
        case .LeftBraket:
            return "대괄호(좌)"
        case .RightBraket:
            return "대괄호(우)"
        }
    }
}
