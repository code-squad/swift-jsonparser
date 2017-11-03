//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by yangpc on 2017. 11. 2..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    
    static func isJSONObjectArray(_ jsonString: String) -> Bool {
        let jsonObjectsRegularExpression = "\\[ (\\{ (((\"[a-zA-Z]+\") \\: ([0-9]+|false|true|\"([a-zA-Z]+\\s)*[a-zA-Z]+\"))\\, )*((\"[a-zA-Z]+\") \\: ([0-9]+|false|true|\"([a-zA-Z]+\\s)*[a-zA-Z]+\"))* \\}\\, )*\\{ (((\"[a-zA-Z]+\") \\: ([0-9]+|false|true|\"([a-zA-Z]+\\s)*[a-zA-Z]+\"))\\, )*((\"[a-zA-Z]+\") \\: ([0-9]+|false|true|\"([a-zA-Z]+\\s)*[a-zA-Z]+\"))* \\} \\]"
        return jsonString.isValidAllString(with: jsonObjectsRegularExpression)
    }
    
    static func isJSONObject(_ jsonString: String) -> Bool {
        let jsonObjectRegularExpression = "\\{ (((\"[a-zA-Z]+\") \\: ([0-9]+|false|true|\"([a-zA-Z]+\\s)*[a-zA-Z]+\"))\\, )*((\"[a-zA-Z]+\") \\: ([0-9]+|false|true|\"([a-zA-Z]+\\s)*[a-zA-Z]+\"))* \\}"
        return jsonString.isValidAllString(with: jsonObjectRegularExpression)
    }
    
    static func isDataArray(_ jsonString: String) -> Bool {
        let datasRegularExpression = "\\[ (([0-9]*|true|false|\"[0-9a-zA-Z]*\")*\\, )*([0-9]+|false|true|\"[0-9a-zA-Z]+\") \\]"
        return jsonString.isValidAllString(with: datasRegularExpression)
    }
}

extension String{
    
    func isValidAllString(with regularExpression: String) -> Bool {
        do {
            // 파라미터로 받은 패턴으로 RegExp 객체 생성.
            let regex = try NSRegularExpression(pattern: regularExpression)
            // 현재 문자열(self)에서 패턴에 매칭되는 결과 반환. (NSTextCheckingResult 배열타입)
            let nsTextResults = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
            let results = nsTextResults.map({
                // NSTextCheckingResult 타입에는 패턴이 매칭되는 문자열 범위 등의 정보가 들어있음.
                // 현재 문자열(self)에서 해당 범위 만큼(Substring)을 String으로 반환.
                return String(self[Range($0.range, in: self)!])
            })
            return [self] == results
     } catch let error {
            print(error.localizedDescription)
            return false
        }
    }

}

