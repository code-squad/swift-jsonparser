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
        let totalCount: Int = self.count
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
    
    func jsonFormMaker() -> String {
        return objectFormMaker(convertType())
    }
    
    private func convertType() -> [String: Type] {
        return self as! [String : Type]
    }
    
    private func objectFormMaker(_ o: [String: Type], _ depth: Int = 0) -> String {
        
        var desription = makeDepth(depth) + "\(TokenForm.openBrace.str)\n"
        
        for key in o.keys {
            let value = o[key]!
            switch value {
            case .number(let n):
                let value = makeDepth(depth + 1) + key + "\t" + TokenForm.colon.str + "\t" + String(n)
                desription += value
            case .string(let s):
                let value = makeDepth(depth + 1) + key + "\t" + TokenForm.colon.str + "\t" + s
                desription = value
            case .bool(let b):
                let value = key + "\t" + TokenForm.colon.str + "\t"  + String(b)
                desription = value
            case .object(let o):
                 let value = makeDepth(depth + 1) + key + "\t" + TokenForm.colon.str + "\n" + objectFormMaker(o, depth + 1)
                desription += value
            case .array(let a):
                let value = makeDepth(depth + 1) + key + "\t" + TokenForm.colon.str + "\n"  + a.jsonFormMaker()
                desription += value
            }
            desription += "\n"
            desription += makeDepth(depth)
            desription += "\(TokenForm.closeBrace.str)"
        }
        return desription
    }
    
    private func makeDepth(_ depth: Int) -> String {
        var depthForm: String = ""
        
        for _ in 0 ..< depth {
            depthForm += "\t"
        }
        
        return depthForm
    }
}
