//
//  Dictionary+.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 5. 14..
//  Copyright © 2018년 JK. All rights reserved.
//

extension Dictionary: JSON {
    func description() -> String {
        
        let (stringCount, booleanCount, numberCount, objectCount, arrayCount, totalCount) = calculationTypeCount()
        
        var descriptionValue = "총 \(totalCount) 개의 객체 데이터 중에 "
        
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
    
    func calculationTypeCount() -> (Int, Int, Int, Int, Int, Int) {
        var totalCount: Int = self.count
        var stringOfCount: Int = 0
        var numberOfCount: Int = 0
        var booleanOfCount: Int = 0
        var objectOfCount: Int = 0
        var arrayOfCount: Int = 0
        
        for value in self.values {
            let value = value as! Type
            
            switch value{
                case .string:
                    stringOfCount += 1
                case .number:
                    numberOfCount += 1
                case .bool:
                    booleanOfCount += 1
                case .object:
                    objectOfCount += 1
                case .array:
                    arrayOfCount += 1
                }
        }
        return (stringOfCount, booleanOfCount, numberOfCount, objectOfCount, arrayOfCount, totalCount)
    }
}
