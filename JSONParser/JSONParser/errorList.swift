//
//  errorList.swift
//  JSONParser
//
//  Created by 김장수 on 30/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum ErrorList: String {
    case emptyInput = "입력값이 없습니다."
    case invalidForm = "배열 또는 객체 형태로 입력하세요."
    case parsingError = "지원하지 않는 형식을 포함하고 있습니다."
    case wrongInput = "터미널에 형식에 맞게 파라미터를 입력하세요."
    case invalidFile = "파일 이름이 올바르지 않습니다."
    case failReadContents = "파일로부터 내용을 읽는데 실패했습니다."
    case saveFail = "파일이 생성되지 않았습니다."
    case noError
}
