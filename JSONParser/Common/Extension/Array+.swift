//
//  Array+.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 5. 14..
//  Copyright © 2018년 JK. All rights reserved.
//

extension Array: JSON {
    
    func description() -> String {
        
        let (stringCount, booleanCount, numberCount, objectCount, arrayCount, totalCount) = calculationTypeCount()
        
         var descriptionValue = "총 \(totalCount) 개의 배열 데이터 중에 "
        
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
        var totalCount = 0
        var stringOfCount = 0
        var booleaOfnCount = 0
        var numberOfCount = 0
        var objectOfCount = 0
        var arrayOfCount = 0
        
        
        for element in self {
            let type = element as? Type
            
            if case .array(let arr)? = type {
                for type in arr {
                    totalCount += 1
                    switch type {                        
                        case .string(_):
                            stringOfCount += 1
                        case .bool(_):
                            booleaOfnCount += 1
                        case .number(_):
                            numberOfCount += 1
                        case .object(_):
                            objectOfCount += 1
                        case .array(_):
                            arrayOfCount += 1
                    }
                }
            }
        }
        return (stringOfCount, booleaOfnCount, numberOfCount, objectOfCount, arrayOfCount, totalCount)
    }
}
