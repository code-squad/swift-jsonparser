//
//  Json.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 6..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

protocol Jsonable {
    func countData() -> (Int,Int,Int,Int,Int)
    func generateData() -> String
}

enum JsonType:Equatable {
    case string(String)
    case int(Int)
    case bool(Bool)
    case object([String:JsonType])
    case array([JsonType])
    
    func description(intent: Int) -> String {
        switch self {
        case .string(let element):
            return element
        case .int(let element):
            return String(element)
        case .bool(let element):
            return String(element)
        case .object(let element):
            let jsonObject = JsonObject.init()
            return jsonObject.makeObject(intent: intent + 1, elements: element)
        case .array(let element):
            let jsonArray = JsonArray.init()
            return jsonArray.makeArray(intent: intent + 1, elements: element)
        }
    }
}

extension Jsonable {
    func countDataWithMessage() -> String {
        let (string,int,bool,object,array) = self.countData()
        let totalCount = string + int + bool + object + array
        var message = ""
        
        if self is JsonArray {
            message = "총 \(totalCount)개의 배열 데이터 중에 "
        }
        
        if self is JsonObject {
            message = "총 \(totalCount)개의 객체 데이터 중에 "
        }
        
        if string > 0 {
            message = message + "문자열 \(string)개,"
        }
        if int > 0 {
            message = message + "숫자 \(int)개,"
        }
        if bool > 0 {
            message = message + "부울 \(bool)개,"
        }
        if object > 0 {
            message = message + "객체 \(object)개,"
        }
        if array > 0 {
            message = message + "배열 \(array)개,"
        }
        message.removeLast() // 마지막 , 는 제거 합니다.
        message = message + "가 포함되어 있습니다."
        
        return message
    }
}
