//
//  OutputView.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/29/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    func printMessage (_ messages: [String: Int]) {
        var ment: String
        
        ment = "총 \(messages["총"] ?? 0)개의 데이터 중에"
        
        for message in messages {
            if message.key != "총" {
                ment += " \(message.key) \(message.value)개,"
            }
        }
        ment.removeLast()
        
        ment += "가 포함되어 있습니다."
        
        print(ment)
    }
}
