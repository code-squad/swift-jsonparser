//
//  OutputView.swift
//  JSONParser
//
//  Created by 이동건 on 06/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    static func display(from results: [JSONParser.JSONParsedResult]) {
        var displayResult = ""
        
        if results.count == 1 {
            displayResult += displayPrefix(results[0].totalDataCounts) ?? ""
            displayResult += displayValue(results[0].resultDict[JSONValueType.string]?.count, type: JSONValueType.string) ?? ""
            displayResult += displayValue(results[0].resultDict[JSONValueType.int]?.count, type: JSONValueType.int) ?? ""
            displayResult += displayValue(results[0].resultDict[JSONValueType.bool]?.count, type: JSONValueType.bool) ?? ""
            displayResult += displayPostFix(results[0].totalDataCounts) ?? ""
        }else{
            displayResult += displayObjects(results.count)
        }
        print(displayResult)
    }
    
    private static func displayObjects(_ count: Int) -> String {
        return "총 \(count)개의 배열 데이터 중에 객체 \(count)개가 포함되어 있습니다."
    }
    
    private static func displayPrefix(_ total: Int) -> String? {
        return total != 0 ? "총 \(total)개의 데이터 중에 " : nil
    }
    
    private static func displayValue<T: RawRepresentable>(_ count: Int?, type: T) -> String? where T.RawValue == String {
        guard let count = count else { return nil }
        return count != 0 ? type.rawValue + " \(count)개 " : nil
    }
    
    private static func displayPostFix(_ total: Int) -> String? {
        return total != 0 ? "가 포함되어 있습니다." : nil
    }
}
