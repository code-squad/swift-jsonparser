//
//  OutputView.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/29/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    func printMessage (_ message : (messages: [JsonTypeName: Int], typeName: JsonTypeName)) {
        var ment: String
        
        ment = "총 \(message.messages[JsonTypeName.total] ?? 0)개의 \(message.typeName.rawValue) 데이터 중에"
        
        for message in message.messages {
            if message.key != JsonTypeName.total {
                ment += " \(message.key.rawValue) \(message.value)개,"
            }
        }
        ment.removeLast()
        
        ment += "가 포함되어 있습니다."
        
        print(ment)
    }
    
    func printElements (_ element: JsonType) {
        print(element.string)
    }
    
    
}
