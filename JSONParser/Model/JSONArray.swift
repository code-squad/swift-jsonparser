//
//  JSONArray.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 4. 26..
//  Copyright © 2018년 JK. All rights reserved.
//

struct JsonArray: JSON {
    
    private var array: [Type] = []
    
    init(_ array: Type) {
        if case .array(let arr) =  array {
            self.array = arr
        }
    }
    
    func description() -> String {
        var descriptionValue = "총 \(array.count) 개의 배열 데이터 중에 "
        
        let (stringCount, numberCount, booleanCount, objectCount, arrayCount) = calculationTypeCount()
        
        if stringCount > 0 {
            descriptionValue += "문자열 \(stringCount)개 "
        }
        
        if numberCount > 0 {
            descriptionValue += "숫자 \(numberCount)개 "
        }
        
        if booleanCount > 0 {
            descriptionValue += "부울 \(booleanCount)개 "
        }
        
        if objectCount > 0 {
            descriptionValue += "객체 \(objectCount)개 "
        }
        
        if arrayCount > 0 {
            descriptionValue += "배열 \(arrayCount)개 "
        }
        
        return descriptionValue + "가 포함되어 있습니다."
    }
    
    func calculationTypeCount() -> (Int, Int, Int, Int, Int) {
        
        var stringCount = 0
        var numberCount = 0
        var booleanCount = 0
        var objectCount = 0
        var arrayCount = 0
        
        let array = self.array[0]
        
        if case .array(let arr) = array {
            for value in arr {
                switch value {
                    case .string:
                        stringCount += 1
                    case .bool:
                        booleanCount += 1
                    case .number:
                        numberCount += 1
                    case .object:
                        objectCount += 1
                    case .array:
                        arrayCount += 1
                }
            }
        }
        
        return (stringCount, numberCount, booleanCount, objectCount, arrayCount)
    }
}
