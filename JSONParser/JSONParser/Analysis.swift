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
                json.addObject(key: first, value: last)
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
    
    // [] or {} 쌍 검사
    public static func checkPair(to jsonData:String) -> Bool {
        let countPrefix1 = jsonData.contains("{")
        let countPrefix2 = jsonData.contains("[")
        let countSuffix1 = jsonData.contains("}")
        let countSuffix2 = jsonData.contains("]")
        guard countPrefix1 == countSuffix1 && countPrefix2 == countSuffix2 else { return false }
        return true
    }
    
    // [] or {} 패턴 검사
    public static func checkPattern(to jsonData:String) -> Bool {
        var data = jsonData
        
        data.removeFirst()
        data.removeLast()
        
        var before = ""
        /*
         [{{,}}]
         {[[,]]}
         {][[[]]}
         [}{]
         {[],[]}
         */
        for d in data {
            // 3 : } or ] 이게 처음부터 나오면 형태 잘못된 것 입니다.
            if before.isEmpty && (d == "}" || d == "]"){
                return false
            }
            // 1 : { or [ 이면 before에 값을 저장함
            if d == "{" || d == "[" {
                before = String(d)
            }
            // 2 : ] or } 이면 before에 동일한 형태가 있는지 확인
            if d == "}" || d == "]" {
                if d == "}" && before == "{" {
                    // Pass : before 초기화
                    before = ""
                }else if d == "]" && before == "[" {
                    // Pass : before 초기화
                    before = ""
                }else {
                    return false
                }
            }
        }
        return true
    }
}

extension String {
    func contains(_ find: String) -> Int{
        var count = 0
        for char in self {
            if find.contains(char) {
                count = count + 1
            }
        }
        return count
    }
}


