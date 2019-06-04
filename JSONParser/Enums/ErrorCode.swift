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
    case notFoundKey
    case convertJsonObjectError
    case convertJsonArrayError
    case createJsonFormatterError
    var description: String  {
        get{
            switch self{
            case .noInput:
                return  "입력값이 없습니다."
            case .invalidJsonFormat:
                return "지원하지 않는 형식을 포함하고 있습니다."
            case .lexicalTypeError:
                return "요소 Type 이 문자열, 숫자, 불린 값 어느 경우도 해당하지 않습니다."
            case .notFoundKey:
                return "JsonObject에서 해당 key에 대한 value 값이 없습니다."
            case .convertJsonObjectError:
                return "JsonObject로 변환 과정에 오류가 있습니다."
            case .convertJsonArrayError:
                return "JsonArray로 변환 과정에 오류가 있습니다."
            case .createJsonFormatterError:
                return "JsonFormatter 생성과정에서 오류가 발생했습니다."
            }
        }
    }
}
