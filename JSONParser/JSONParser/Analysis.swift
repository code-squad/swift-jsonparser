//
//  Analysis.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 2..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct Analysis {
    
    /*
     1.[]
     1-1.{
     1-2.else
     2.{}
     */
    
    public static func analysisJsonObject(to jsonData:String) -> JsonArray {
        var json = JsonArray.init()
        let data = jsonData.trimmingCharacters(in: .whitespacesAndNewlines)
        let elements:[String] = data.components(separatedBy: "{")
        
        for e in elements {
            var element = e.trimmingCharacters(in: .whitespacesAndNewlines)
            if !element.isEmpty {
                if element.hasSuffix(",") {
                    element.removeLast()
                }
                json.addArray(element: "{ \(element)")
            }
        }
        
        return json
    }
    
    public static func analysisJsonSimple(to jsonData:String) -> JsonArray {
        var json = JsonArray.init()
        let elements:[String] = jsonData.components(separatedBy: ",")
        for e in elements {
            let element = e.trimmingCharacters(in: .whitespacesAndNewlines)
            json.addArray(element: element)
        }
        
        return json
    }
    
    public static func analysisJsonDictionary(to jsonData:String) -> JsonObject {
        let temp1 = jsonData.components(separatedBy: ",")
        var json = JsonObject.init()
        for temp2 in temp1 {
            let temp3 = temp2.components(separatedBy: ":")
            if var first = temp3.first , var last = temp3.last {
                first = first.trimmingCharacters(in: .whitespacesAndNewlines)
                last = last.trimmingCharacters(in: .whitespacesAndNewlines)
                json.addDictionary(key: first, value: last)
            }
        }
        
        return json
    }
    
    // 분석 함수
    public static func analysisJson(to jsonData:String) -> JsonProtocol {
        // jsonData를 아래서 remove 할 수 없어서 아래와 같이 변수에 넣었습니다.
        var data = jsonData
        
        if data.hasPrefix("["){
            // 배열데이터
            data.removeFirst()
            data.removeLast()
            
            let jsonArray = data.trimmingCharacters(in: .whitespacesAndNewlines)
            if jsonArray.hasPrefix("{") {
                let object = analysisJsonObject(to: data)
                return object
            }else{
                let simple = analysisJsonSimple(to: data)
                return simple
            }
        }else{
            // 객체데이터
            data.removeFirst()
            data.removeLast()
            let dictionary = analysisJsonDictionary(to: data)
            return dictionary
        }
    }
}
