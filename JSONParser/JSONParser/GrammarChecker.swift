//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by Elena on 10/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

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
    private static let space = "\\s"
    private static let colon = ":"
    private static let leftBracket = "\\{"
    private static let rightBracket = "\\}"
    private static let leftBigBracket = "\\["
    private static let rightBigBracket = "\\]"
    
    private static let string = "\"[\\w_\(space)\']+\""
    private static let int = "[0-9]+"
    private static let bool = "(?:true|false)"
    
    private static let values = "\(string)|\(int)|\(bool)"
    private static let keyValue = "\(string)\(space)*\(colon)\(space)*(?:\(values))"
    
    private static let object = "\(leftBracket)\(space)*\(keyValue)\(space)*(?:,\(space)*\(keyValue)\(space)*)*\(rightBracket)"
    private static let valuesInObject = "\(values)|\(object)"
    
    private static let array = "\(leftBigBracket)\(space)*(?:\(valuesInObject))\(space)*(?:,\(space)*(?:\(valuesInObject))\(space)*)*\(rightBigBracket)"
    static let valuesInArray = "\(valuesInObject)|\(array)"
    static let keyValueInArray = "\(string)\(space)*\(colon)\(space)*(?:\(valuesInArray))"
    
    static let jsonObject = "^\(leftBracket)\(space)*\(keyValueInArray)\(space)*(?:,\(space)*\(keyValueInArray)\(space)*)*\(rightBracket)$"
    static let jsonArray = "^\(leftBigBracket)\(space)*(?:\(valuesInArray))\(space)*(?:,\(space)*(?:\(valuesInArray))\(space)*)*\(rightBigBracket)$"

    static func regexTest(pattern: String) -> (String) -> Bool {
        let expression: NSRegularExpression? = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return { (input: String) -> Bool in
            guard let expression = expression else { return false }
            let inputRange = NSMakeRange(0, input.characters.count)
            let matches = expression.matches(in: input, options: [], range: inputRange)
            return matches.count > 0
        }
    }
}

