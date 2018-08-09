//
//  OutputView.swift
//  JSONParser
//
//  Created by 이동건 on 06/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum AvailableJSONType: String {
    case string = "문자열"
    case int = "숫자"
    case bool = "부울"
}

struct OutputView {
    
    static func display(from parsedObjects: [JSONParser.JSONParsedResult]) {
        var displayResult = ""
        
        if parsedObjects.count == 1 {
            displayResult += displayPrefix(parsedObjects[0].results.count) ?? ""
            displayResult += displayValues(parsedObjects[0])
            displayResult += displayPostFix(parsedObjects[0].results.count) ?? ""
        }else{
            displayResult += displayObjects(parsedObjects.count)
        }
        print(displayResult)
    }
    
    private static func displayValues(_ objects: JSONParser.JSONParsedResult) -> String {
        let typeCountingResult = countingType(of: objects)
        let displayableCountOfStrings = displayValue(typeCountingResult.stringsCount, type: JSONValueType.string) ?? ""
        let displayableCountOfIntegers = displayValue(typeCountingResult.integersCount, type: JSONValueType.int) ?? ""
        let displayableCountOfBooleans = displayValue(typeCountingResult.booleansCount, type: JSONValueType.bool) ?? ""
        
        return displayableCountOfStrings + displayableCountOfIntegers + displayableCountOfBooleans
    }
    
    private static func countingType(of objects: JSONParser.JSONParsedResult) -> (stringsCount: Int, integersCount: Int, booleansCount: Int) {
        var stringsCount: Int = 0
        var integersCount: Int = 0
        var booleansCount: Int = 0
        
        objects.results.forEach {
            var value = $0
            if let object = $0 as? [String:JSONElementProtocol] {
                value = object.values.first!
            }
            switch value {
            case let type where type is String: stringsCount += 1
            case let type where type is Int: integersCount += 1
            case let type where type is Bool: booleansCount += 1
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
