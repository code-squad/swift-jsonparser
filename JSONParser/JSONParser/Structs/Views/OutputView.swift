//
//  OutputView.swift
//  JSONParser
//
//  Created by 이동영 on 18/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    let counter = JsonValueCounter()
    let jsonValue: JsonValue
    
    
    init(_ jsonValue: JsonValue ) {
        self.jsonValue = jsonValue
    }
    
    mutating func run() {
        let result = self.makeSentence()
        print(result)
    }
    
    private mutating func makeSentence() -> String {
        var result = ""
        var total = 0
        print(self.jsonValue)
        let numOf = counter.count(target: self.jsonValue)
        _ = numOf.map{
            result = "\(result) \($0.key) \($0.value)개"
            total += $0.value
        }
        result += "가 포함되어 있습니다."
        result = "총 \(total)개의 \(self.jsonValue.describeType()) 데이터 중에\(result)"
        return result
    }
    
}
