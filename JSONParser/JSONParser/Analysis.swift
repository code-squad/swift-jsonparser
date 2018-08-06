//
//  Analysis.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 2..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct Analysis {
    // 분석 함수
    public static func analysisJson(to jsonData:String) -> Json {
        var json = Json.init()
        
        var data = jsonData
        data.removeFirst()
        data.removeLast()

        let elements:[String] = data.components(separatedBy: ",")
        let allowCharacterSet = CharacterSet.init(charactersIn: "1234567890")
        for e in elements {
            let element = e.trimmingCharacters(in: .whitespacesAndNewlines)
            if element.contains("true") || element.contains("false"){
                json.addBool()
            }else if element.trimmingCharacters(in: allowCharacterSet).isEmpty {
                json.addInt()
            }else {
                json.addString()
            }
        }
        return json
    }
}
