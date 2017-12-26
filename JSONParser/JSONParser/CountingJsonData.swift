//
//  CountingJsonData.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 26..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct CountingJsonData {
    
    static func makeCountedTypeInstance (_ input: Any) -> JsonData {
        switch input {
        case is Dictionary<String,Any> :
            return getCountedObjectType(input as! [String : Any])
        default:
            return getCountedArrayType(input as! [String])
        }
    }
    
    //  객체타입의 카운팅 인스턴스 생성
    private static func getCountedObjectType(_ objectValue: [String:Any]) -> JsonData {
        let (countOfNum, countOfBool, countOfString, countOfArray) = countOfValueTypeInObject(objectValue)
        return JsonData(countOfNum, countOfBool, countOfString, countOfArray)
    }
    
    //  배열 타입의 카운팅 인스턴스 생성
    private static func getCountedArrayType(_ arrayValue: [String]) -> JsonData {
        var countOfNumber: Int = 0
       var countOfBool: Int = 0
       var countOfString: Int = 0
       var countOfObject: Int = 0
        var countOfofArray: Int = 0
        _ = arrayValue.forEach {
            if $0.hasPrefix("{") && $0.hasSuffix("}") { countOfObject += 1}
            else if $0.hasPrefix("[") && $0.hasSuffix("]") { countOfofArray += 1 }
            else if let _ = Int($0) { countOfNumber += 1}
            else if let _ = Bool($0) { countOfBool += 1}
            else if  let firstString = $0.first, firstString == "\"" {countOfString += 1}
        }
        return JsonData(countOfNumber, countOfBool, countOfString, countOfObject, countOfofArray)
    }
    
    //  객체 내의 값의 타입 갯수를 세어 반환
    static func countOfValueTypeInObject(_ objects: [String:Any]) -> (countOfNum: Int, countOfBool: Int, countOfString: Int, countOfArray: Int){
        var countOfNumber: Int = 0
        var countOfBool: Int = 0
        var countOfString: Int = 0
        var countOfofArray: Int = 0
        _ = objects.forEach {
            if let _ =  $0.value  as? Int {
                countOfNumber += 1
            } else if let stringLikeArray = $0.value as? String, stringLikeArray.contains("[") {
                countOfofArray += 1
            } else if let _ = $0.value as? Bool {
                countOfBool += 1
            }else if $0.value is String { countOfString += 1 }
        }
        return (countOfNumber, countOfBool, countOfString, countOfofArray)
    }
    
}
