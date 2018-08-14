//
//  OutputView.swift
//  JSONParser
//
//  Created by 이동건 on 06/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    static func display(_ values: JSONType){
        print(text(from: values))
    }
    
    static func display(_ error: JSONParserError) {
        print(error.description)
    }
    
    private static func text(from value: JSONType) -> String {
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
        
        text += "가 존재합니다."
        
        return text
    }
}

