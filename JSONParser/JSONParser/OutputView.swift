//
//  OutputView.swift
//  JSONParser
//
//  Created by 이동건 on 06/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum JSONValueType: String {
    case string = "문자열"
    case int = "숫자"
    case bool = "부울"
}

struct OutputView {
    
    static func display(from parsedObjects: [JSONParser.JSONParsedResult]) {
        var displayResult = ""
        
        if parsedObjects.count == 1 {
            displayResult += displayPrefix(parsedObjects[0].result.count) ?? ""
            displayResult += displayValues(parsedObjects[0].result)
            displayResult += displayPostFix(parsedObjects[0].result.count) ?? ""
        }else{
            displayResult += displayObjects(parsedObjects.count)
        }
        print(displayResult)
    }
    
    private static func displayValues(_ jsonObjects: [String:String]) -> String {
        let typeCountingResult = checkTypeOfValues(jsonObjects)
        let displayableCountOfStrings = displayValue(typeCountingResult.stringsCount, type: JSONValueType.string) ?? ""
        let displayableCountOfIntegers = displayValue(typeCountingResult.integersCount, type: JSONValueType.int) ?? ""
        let displayableCountOfBooleans = displayValue(typeCountingResult.booleansCount, type: JSONValueType.bool) ?? ""
        
        return displayableCountOfStrings + displayableCountOfIntegers + displayableCountOfBooleans
    }
    
    private static func checkTypeOfValues(_ jsonObjects: [String:String]) -> (stringsCount: Int, integersCount: Int, booleansCount: Int) {
        var stringsCount: Int = 0
        var integersCount: Int = 0
        var booleansCount: Int = 0
        jsonObjects.forEach { (_, value) in
            switch value {
            case let value where value.contains("\""): stringsCount += 1
            case let value where Int(value) != nil : integersCount += 1
            case let value where Bool(value) != nil : booleansCount += 1
            default: return
            }
        }
        return (stringsCount, integersCount, booleansCount)
    }
    
    private static func displayObjects(_ count: Int) -> String {
        return "총 \(count)개의 배열 데이터 중에 객체 \(count)개가 포함되어 있습니다."
    }
    
    private static func displayPrefix(_ total: Int) -> String? {
        return total != 0 ? "총 \(total)개의 데이터 중에 " : nil
    }
    
    private static func displayValue<T: RawRepresentable>(_ count: Int, type: T) -> String? where T.RawValue == String {
        return count != 0 ? type.rawValue + " \(count)개 " : nil
    }
    
    private static func displayPostFix(_ total: Int) -> String? {
        return total != 0 ? "가 포함되어 있습니다." : nil
    }
}
