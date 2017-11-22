//
//  GuideMessage.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 22..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

enum GuideMessage: String, Error {
    // guide
    case inputRequest = "분석할 JSON 데이터를 입력하세요."
    // error
    case wrongInput = "입력이 올바르지 않습니다."
    case outputError = "출력이 정상적으로 이루어지지 않았습니다"
    case notJSONPattern = "지원하지 않는 형식을 포함하고 있습니다."
    // file
    case baseDirPath = "./MyProject/CodeSquad/Masters/Level2/swift-jsonparser/JSONParser/JSONFile/"
    case defaultFileName = "output.json"

}
