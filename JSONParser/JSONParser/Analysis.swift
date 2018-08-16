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
    public static func analysisJson(to jsonData:String) -> Jsonable {
        // jsonData를 아래서 remove 할 수 없어서 아래와 같이 변수에 넣었습니다.
        var data = jsonData
        
        if data.isArray(){
            // 배열데이터
            data.removeFirst()
            data.removeLast()
            
            // parse
            let parseArray = JsonParse.parseJsonArray(to: data)
            
            // make
            let jsonArray = JsonArray.init(jsonArray: parseArray)
            return jsonArray
            
        }else{
            // 객체데이터
            data.removeFirst()
            data.removeLast()
            
            // parse
            let parseObject = JsonParse.parseJsonObject(to: data)
            
            // make
            let jsonObject = JsonObject.init(jsonObject: parseObject)
            return jsonObject
        }
    }

}
