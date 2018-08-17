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
        // 배열데이터
        if jsonData.isArray(){
            // parse
            let parseArray = JsonParse.makeArray(to: jsonData)
            
            // make
            let jsonArray = JsonArray.init(jsonArray: parseArray)
            return jsonArray
        
        // 객체데이터
        }else{
            // parse
            let parseObject = JsonParse.makeObject(to: jsonData)
            
            // make
            let jsonObject = JsonObject.init(jsonObject: parseObject)
            return jsonObject
        }
    }

}
