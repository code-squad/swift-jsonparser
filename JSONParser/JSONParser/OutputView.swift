//
//  OutputView.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    static func printJSONData(_ jsonData: JSONPrintable) {
        var result = "총 \(jsonData.total()) 데이터 중에 "
        
        if jsonData.countObjects() == 1 {
            if jsonData.countCharacters() > 0 {
                result += jsonData.prefixOfCharacters
                result += "\(jsonData.countCharacters())개,"
            }
            
            if jsonData.countNumbers() > 0 {
                result += jsonData.prefixOfNumbers
                result += "\(jsonData.countNumbers())개,"
            }
            
            if jsonData.countBooleans() > 0 {
                result += jsonData.prefixOfBooleans
                result += "\(jsonData.countBooleans())개,"
            }
        } else {
            result += jsonData.prefixOfObjects
            result += "\(jsonData.countObjects())개,"
            
            if jsonData.countCharacters() > 0 {
                result += jsonData.prefixOfCharacters
                result += "\(jsonData.countCharacters())개,"
            }
            
            if jsonData.countNumbers() > 0 {
                result += jsonData.prefixOfNumbers
                result += "\(jsonData.countNumbers())개,"
            }
            
            if jsonData.countBooleans() > 0 {
                result += jsonData.prefixOfBooleans
                result += "\(jsonData.countBooleans())개,"
            }
        }

        result.removeLast()
        result += "가 포함되어 있습니다."
        
        print(result)
    }
}


//문자 숫자 부울 순서
