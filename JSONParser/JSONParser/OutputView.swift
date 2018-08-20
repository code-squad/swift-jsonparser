//
//  OutputView.swift
//  JSONParser
//
//  Created by 이동건 on 06/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    private static var stageOfObject: Int = 0
    private static var stageOfArray: Int = 0
    
    static func display(_ values: JSONType){
        print(presentResult(from: values))
        print(values.text)
    }
    
    static func display(_ error: JSONParserError) {
        print(error)
    }
    
    private static func presentResult(from value: JSONType) -> String {
        var text = ""
        let result = value.result
        text += value.prefix
        
        if result.string > 0 {
            text += " 문자열 \(result.string)개 "
        }
        
        if result.int > 0 {
            text += " 정수 \(result.int)개 "
        }
        
        if result.bool > 0 {
            text += " 부울 \(result.bool)개 "
        }
        
        if result.object > 0 {
            text += " 객체 \(result.object)개 "
        }
        
        if result.array > 0 {
            text += " 배열 \(result.array)개 "
        }
        
        text += "가 존재합니다."
        
        return text
    }
}

