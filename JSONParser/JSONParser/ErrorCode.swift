//
//  ErrorCode.swift
//  JSONParser
//
//  Created by hw on 07/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum ErrorCode: Error, CustomStringConvertible{

    case noInput
    case invalidJsonFormat
    case lexicalTypeError
    
    var description: String  {
        get{
            switch self{
            case .noInput:
                return  "입력값이 없습니다."
            case .invalidJsonFormat:
                return "유효하지 않은 json 포맷입니다."
            case .lexicalTypeError:
                return "요소 Type 이 문자열, 숫자, 불린 값 어느 경우도 해당하지 않습니다."
            }
        }
    }
}
