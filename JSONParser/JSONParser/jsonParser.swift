//
//  jsonParser.swift
//  JSONParser
//
//  Created by 김장수 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    // 문자열의 배열을 각 데이터 형태에 따라 갯수를 카운트 & 튜플로 리턴
    public func countsOfJSON(from text: String) -> (string: Int, bool: Int, int: Int) {
        let texts = text.removeBracket.separateByComma
        var nString = 0, nBoolean = 0, nInt = 0
        
        for element in texts {
            if element.isNumeric { nInt += 1 }
            if element.isString { nString += 1 }
            if element.isBoolean { nBoolean += 1 }
        }
        
        return (string: nString, bool: nBoolean, int: nInt)
    }
}
