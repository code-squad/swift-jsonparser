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
    
    public static func analysisJsonObject(to jsonData:String) -> Json {
        var json = Json.init()
        let data = jsonData.trimmingCharacters(in: .whitespacesAndNewlines)
        let elements:[String] = data.components(separatedBy: "{")
        
        for e in elements {
            var element = e.trimmingCharacters(in: .whitespacesAndNewlines)
            if !element.isEmpty {
                if element.hasSuffix(",") {
                    element.removeLast()
                }
                json.addObject(element: "{ \(element)")
            }
        }
        
        return json
    }
    
    public static func analysisJsonSimple(to jsonData:String) -> Json {
        var json = Json.init()
        let elements:[String] = jsonData.components(separatedBy: ",")
        let allowCharacterSet = CharacterSet.init(charactersIn: "1234567890")
        for e in elements {
            let element = e.trimmingCharacters(in: .whitespacesAndNewlines)
            if element.contains("true") || element.contains("false"){
                json.addBool(element: element)
            }else if element.trimmingCharacters(in: allowCharacterSet).isEmpty {
                json.addInt(element: element)
            }else {
                json.addString(element: element)
            }
        }
        
        return json
    }
    
    // 분석 함수
    public static func analysisJson(to jsonData:String) -> Json {
        var json = Json.init()
        
        var data = jsonData
        
        if data.hasPrefix("["){
            data.removeFirst()
            data.removeLast()
            
            let jsonArray = data.trimmingCharacters(in: .whitespacesAndNewlines)
            if jsonArray.hasPrefix("{") {
                json = analysisJsonObject(to: data)
            }else{
                json = analysisJsonSimple(to: data)
            }
            
        }else if data.hasPrefix("{") {
            // 구현해야함
            print("객체데이터!")
        }
        
        return json
    }
}
