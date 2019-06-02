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
    var total: Int = 0
    
    init(_ jsonValue: JsonValue ) {
        self.jsonValue = jsonValue
    }
    
    mutating func run() {
        let result = self.makeSentence()
        print(result)
    }
    
    private mutating func makeSentence() -> String {
        var result = ""
        let numOf = counter.count(target: self.jsonValue)
        _ = numOf.map{
            result = "\(result) \($0.key) \($0.value)개 "
            total += $0.value
        }
        result += "가 포함되어 있습니다."
        result = "총 \(self.total)개의 \(self.jsonValue.describeType()) 데이터 중에" + result
        return result
        // 총 (4)개의 (객체) 데이터 중에 (문자열) (2)개, (숫자) (1)개, (부울) (1)개가 포함되어 있습니다.
    }
    
}
