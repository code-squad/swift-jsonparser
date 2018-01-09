//
//  ProgramMessage.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2018. 1. 5..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

enum Message: Error, CustomStringConvertible {
    case ofWelcoming
    case ofEndingProgram
    case ofInvalidFormat
    case ofFailedProcessingFile
    case ofDefaultJSONFileName
    case ofSuccessProcessingFile
    var description: String {
        switch self {
        case .ofWelcoming :
            return "분석할 JSON 데이터를 입력하세요. quit입력시 종료됩니다"
        case .ofEndingProgram :
            return "quit"
        case .ofInvalidFormat :
            return "JSON 입력형식에 맞지 않습니다."
        case .ofFailedProcessingFile :
            return "파일 작업중 오류가 발생했습니다."
        case .ofDefaultJSONFileName :
            return "output.json"
        case .ofSuccessProcessingFile:
            return "파일이 성공적으로 생성되었습니다."
        }
    }
}

enum ElementOfString: String, CustomStringConvertible {
    case whitespace = " "
    case leftSquareBracket = "["
    case rightSquareBracket = "]"
    case leftBrace = "{"
    case rightBrace = "}"
    case comma = ","
    case colon = ":"
    case doubleQuotationMarks = "\""
    case emptyString = ""
    var description: String {
        return self.rawValue
    }
}
