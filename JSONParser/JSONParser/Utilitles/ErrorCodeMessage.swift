//
//  ErrorCodeMessage.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 24..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

enum ErrorCode: String, Error {
    case invalidInputString = "입력값을 확인해주세요 :)"
    case invalidJSONStandard = "!!WARNING : JSON규격에 맞지않습니다. 올바른 입력값을 넣어주세요!!"
    case invalidPatten = "Regex 패턴이 맞지 않습니다. 확인해주세요 :)"
    case invalidCommandlineArgument = "커맨드라인 Argument입력 초과입니다."
    case invalidFilePath = "파일이 경로에 없습니다."
}
