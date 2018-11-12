//
//  jsonParser.swift
//  JSONParser
//
//  Created by 김장수 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    // 문자열의 배열을 각 데이터 형태에 프로토콜(SwiftArray)로 리턴
    public func parse() -> SwiftArray {
        
        
        return JSONData(ints: [Int](), bools: [Bool](), strings: [String]())
    }
}
