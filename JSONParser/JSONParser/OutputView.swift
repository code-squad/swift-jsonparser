//
//  OutputView.swift
//  JSONParser
//
//  Created by 이동건 on 06/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    static func display(json: [String], strings: [String], integers: [Int], booleans: [Bool]) {
        print("\(displayPrefix(json) ?? "")\(displayStrings(strings) ?? "")\(displayIntegers(integers) ?? "")\(displayBooleans(booleans) ?? "")\(displayPostFix(json) ?? "")")
    }
    
    private static func displayPrefix(_ json: [String]) -> String? {
        return json.count != 0 ? "총 \(json.count)개의 데이터 중에" : nil
    }
    
    private static func displayStrings(_ strings: [String]) -> String? {
        return strings.count != 0 ? "문자열 \(strings.count)개, " : nil
    }
    
    private static func displayIntegers(_ integers: [Int]) -> String? {
        return integers.count != 0 ? "숫자 \(integers.count)개, " : nil
    }
    
    private static func displayBooleans(_ booleans: [Bool]) -> String? {
        return booleans.count != 0 ? "부울 \(booleans.count)개" : nil
    }
    
    private static func displayPostFix(_ json: [String]) -> String? {
        return json.count != 0 ? "가 포함되어 있습니다." : nil
    }
}
