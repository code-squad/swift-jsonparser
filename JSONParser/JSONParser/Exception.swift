//
//  Exception.swift
//  JSONParser
//
//  Created by 이동영 on 11/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

typealias ErrorMessage = String

enum Exception: ErrorMessage,Error,CustomStringConvertible {
    var description: String { return self.rawValue }
    
    case wrongFormat = "잘못된 입력형식 입니다."
    case RegexConversionFail = "정규표현식을 지원하지 않는 패턴입니다."
}
