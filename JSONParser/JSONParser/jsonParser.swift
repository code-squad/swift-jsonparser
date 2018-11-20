//
//  jsonParser.swift
//  JSONParser
//
//  Created by 김장수 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    // 문자열을 파싱해서 각 데이터 형태에 맞게 프로토콜로 리턴
    func parse(from input: String) -> Parsable {
        guard input.isArray else { return parseObject(of: input) }
        return parseArray(of: input)
    }
    
    // 배열 파싱
    private func parseArray(of input: String) -> Parsable {
        let pattern = "\"[\\w\\s*]+\"|[0-9]+|true|false|\\{(?:(?:\\s*\"[\\w\\s*]+\"\\s*:\\s*[\"\\w\\s*]+\\s*),*)*\\}"
        let elements = classify(input, with: pattern)
        
        return ArrayJSONData(elements: elements)
    }
    
    // 객체 파싱
    private func parseObject(of input: String) -> Parsable {
        let pattern = "\"[\\w\\s*]+\"\\s*:\\s*\"[\\w\\s*]+\"|[0-9]+|true|false"
        let elements = classify(input, with: pattern)
        
        return ObjectJSONData(elements: elements)
    }
    
    // 입력과 정규표현식을 이용하여 배열로 분리
    private func classify(_ text: String, with pattern: String) -> [String] {
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let textNS = text as NSString
        let rangeNS = NSRange(location: 0, length: textNS.length)
        let classified = regex.matches(in: text, options: [], range: rangeNS).map {
            textNS.substring(with: $0.range)
        }
        
        return classified
    }
    
    
}
