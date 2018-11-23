//
//  regularExpression.swift
//  JSONParser
//
//  Created by 김장수 on 23/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONRegex {
    private let objectPattern = "\"[\\w\\s*]+\"\\s*:\\s*(\"[\\w\\s*]+\"|[0-9]+|true|false)"
    private let arrayPattern = "\"[\\w\\s*]+\"|[0-9]+|true|false|\\{(?:(?:\\s*\"[\\w\\s*]+\"\\s*:\\s*[\"\\w\\s*]+\\s*),*)*\\}"
    private let rawData: String
    
    init(rawData: String) {
        self.rawData = rawData
    }
    
    func takeArray() -> [String] {
        return classify(self.rawData, with: arrayPattern)
    }
    
    func takeObject() -> [String] {
        return classify(self.rawData, with: objectPattern)
    }
    
    // 입력과 정규표현식을 이용하여 배열로 분리
    private func classify(_ text: String, with pattern: String) -> [String] {
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let textNS = text as NSString, rangeNS = NSRange(location: 0, length: textNS.length)
        let classified = regex.matches(in: text, options: [], range: rangeNS).map {
            textNS.substring(with: $0.range)
        }
        
        return classified
    }
}
