//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 20..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    
    func isValidFirstString(_ inputValue: String) -> Bool {
        return inputValue.hasPrefix("[") || inputValue.hasPrefix("{")
    }
    
    func isValidLastString(_ inputValue: String) -> Bool {
        return inputValue.hasSuffix("]") || inputValue.hasSuffix("}")
    }
    
    //괄호 지운 데이터를 파라미터로 받아서 " 따옴표 체크, : 콜론체크
    func isValidFirstQuotation(_ quotationData: [String]) -> Bool {
        for data in quotationData {
            return data.hasPrefix("\"") && data.contains(":")
        }
        return false
    }
}


