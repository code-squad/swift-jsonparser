//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by Elena on 10/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

extension String {
    func splitByComma() -> [String] {
        return self.split(separator: ",").map({ String($0)})
    }
    func removeBothFirstAndLast() -> String {
        return String(self.dropFirst().dropLast())
    }
    func splitByColon() -> [String] {
        return self.split(separator: ":").map({ String($0)})
    }
    func splitByBracket() -> [String] {
        return self.split(separator: "{").map({ String($0)})
    }
}
/* 실행 결과 변환
 첫번째 데이터 정규식 (x)
 \["[\w_\s']+":(?:"[\w_\s']+"|[0-9]+|(?:true|false))\]
 두번째 데이터 정규식 (x)
 \{"[\w_\s']+":(?:"[\w_\s']+"|[0-9]+|(?:true|false)|\[(?:"[\w_\s']+",)*"[\w_\s']+"\])\}
 세번째 데이터 정규식 (0)
 \{(?:"[\w_\s']+":(?:"[\w_\s']+"|[0-9]+|(?:true|false)),)*"[\w_\s']+":(?:"[\w_\s']+"|[0-9]+|(?:true|false))\}
 네번째 데이터 정규식 (0)
 \[(?:\{(?:"[\w_\s']+":(?:"[\w_\s']+"|[0-9]+|(?:true|false)),)*"[\w_\s']+":(?:"[\w_\s']+"|[0-9]+|(?:true|false))\},)*\{(?:"[\w_\s']+":(?:"[\w_\s']+"|[0-9]+|(?:true|false)),)*"[\w_\s']+":(?:"[\w_\s']+"|[0-9]+|(?:true|false))\}\]
 */

struct GrammarChecker {
    static let space = "\\s"
    static let colon = ":"
    static let leftBracket = "\\{"
    static let rightBracket = "\\}"
    static let leftBigBracket = "\\["
    static let rightBigBracket = "\\]"
    
    static let string = "\"[\\w_\(space)\']+\""
    static let int = "[0-9]+"
    static let bool = "(?:true|false)"
    
    static let values = "\(string)|\(int)|\(bool)"
    static let keyValue = "\(string)\(space)*\(colon)\(space)*(?:\(values))"
    
    static let jsonObject = "^\(leftBracket)\(space)*\(keyValue)\(space)*(?:,\(space)*\(keyValue)\(space)*)*\(rightBracket)$"
    
    static let object = "\(leftBracket)\(space)*\(keyValue)\(space)*(?:,\(space)*\(keyValue)\(space)*)*\(rightBracket)"
    static let valuesObject = "\(values)|\(object)"
    static let jsonArray = "^\(leftBigBracket)\(space)*(?:\(valuesObject))\(space)*(?:,\(space)*(?:\(valuesObject))\(space)*)*\(rightBigBracket)$"
}

