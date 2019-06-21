//
//  OutputView.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static private let unsupportedPatternMessage = "지원하지 않는 형식입니다."
    static private let unexpectedErrorMessage = "Other Unexpected Error"
    static private let suffixCountDescription = "가 포함되어 있습니다."
    static private let emptyString = ""
    
    static func printMessage(of error: JSONError) {
        print(error.message)
    }
    
    static func printUnexpectedErrorMessage() {
        print(unexpectedErrorMessage)
    }
    static func noticeUnsupportedPattern() {
        print(unsupportedPatternMessage)
    }
    
    static func printTypeCountDescription(of value: JSONValue) {
        guard let typeCountableJSONValue = value as? JSONValue & TypeCountable else {
            noticeUnsupportedPattern()
            return
        }
        print("\(typeCountDescription: typeCountableJSONValue)")
    }
    
    }
}
