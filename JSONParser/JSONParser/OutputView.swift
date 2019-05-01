//
//  OutputView.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/29/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    func printMessage (_ message : (messages: [String: Int], typeName: String)) {
        var ment: String
        
        ment = "총 \(message.messages["총"] ?? 0)개의 \(message.typeName) 데이터 중에"
        
        for message in message.messages {
            if message.key != "총" {
                ment += " \(message.key) \(message.value)개,"
            }
        }
        ment.removeLast()
        
        ment += "가 포함되어 있습니다."
        
        print(ment)
    }
}
