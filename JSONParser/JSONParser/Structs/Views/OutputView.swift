//
//  OutputView.swift
//  JSONParser
//
//  Created by 이동영 on 18/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    private let counter = JsonValueCounter()
    private let json: JsonValue
    
    init(json: JsonValue) {
        self.json = json
    }
    
    func outputStatistics() {
        print(makeStatistics(json: self.json))
    }
    
    func outputSerialization() {
        print(self.json.serialize(indent: 0))
    }
    
    private func makeStatistics(json: JsonValue) -> String {
        var result = ""
        var total = 0
        let countOf = counter.count(target: json)
        _ = countOf.map{
            result = "\(result) \($0.key) \($0.value)개"
            total += $0.value
        }
        result += "가 포함되어 있습니다."
        result = "총 \(total)개의 \(json.describeType()) 데이터 중에\(result)"
        return result
    }
    
}
