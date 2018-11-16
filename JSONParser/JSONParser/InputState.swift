//
//  ErrorState.swift
//  JSONParser
//
//  Created by 윤동민 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum InputState : String {
    case notArrayOrObjectType = "JSON 배열, 객체형식이 아닙니다."
    case notSupportingType = "지원하는 타입이 아닙니다."
    case notCorrectObjectFormat = "객체의 형태가 올바르지 않습니다."
    case rightInput = ""
}
