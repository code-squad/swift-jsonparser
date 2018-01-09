//
//  CountingJsonData.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 26..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct CountingJSONData {
    
    // 카운팅된 JsonData 인스턴스 생성
    static func makeCountedTypeInstance (JSONType: JSONDataCommon) -> JSONData {
        return JSONType.getCountedType()
    }
    
    //  객체타입의 카운팅 인스턴스 생성
    static func getCountedObjectType(_ objectValue: [String:JSONType]) -> JSONData {
        let (countOfNum, countOfBool, countOfString, countOfArray) = countOfValueTypeInObject(objectValue)
        return JSONData(countOfNum, countOfBool, countOfString, countOfArray)
    }
    
    //  배열 타입의 카운팅 인스턴스 생성
    static func getCountedArrayType(_ arrayValue: [JSONType]) -> JSONData {
        var countOfNumber: Int = 0
        var countOfBool: Int = 0
        var countOfString: Int = 0
        var countOfObject: Int = 0
        var countOfofArray: Int = 0
        arrayValue.forEach {
            if $0 is [String:JSONType] { countOfObject += 1}
            else if $0 is [JSONType] { countOfofArray += 1 }
            else if $0 is Int { countOfNumber += 1}
            else if $0 is Bool { countOfBool += 1}
            else if  $0 is String {countOfString += 1}
        }
        return JSONData(countOfNumber, countOfBool, countOfString, countOfObject, countOfofArray)
    }
    
    //  객체 내의 값의 타입 갯수를 세어 반환
    static func countOfValueTypeInObject(_ objects: [String:JSONType]) -> (countOfNum: Int, countOfBool: Int, countOfString: Int, countOfArray: Int){
        var countOfNumber: Int = 0
        var countOfBool: Int = 0
        var countOfString: Int = 0
        var countOfofArray: Int = 0
        objects.forEach {
            if $0.value is Int { countOfNumber += 1 }
            else if $0.value is [JSONType] { countOfofArray += 1 }
            else if $0.value is Bool { countOfBool += 1 }
            else if $0.value is String { countOfString += 1 }
        }
        return (countOfNumber, countOfBool, countOfString, countOfofArray)
    }
    
}
