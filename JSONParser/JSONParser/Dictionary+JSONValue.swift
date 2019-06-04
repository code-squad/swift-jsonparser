//
//  Dictionary+JSONValue.swift
//  JSONParser
//
//  Created by BLU on 2019. 6. 5..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == [JSONValue] {
    
    var valuesCount: Int {
        return self.values.flatMap { $0 }.count
    }
    
    var valuesDescription: String {
        return "\(self.map { "\($0) \($1.count)개" }.joined(separator: ","))"
    }
    
    var description: String {
        return "총 \(self.valuesCount)개의 데이터 중에 \(self.valuesDescription)가 포함되어 있습니다."
    }
}
