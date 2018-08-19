//
//  OutputView.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 2..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    public static func printErrorMessage(error:JsonError){
        print(error.description())
    }
    
    public static func printJson(to json:Jsonable){
        // 객체 데이터 종류 출력하기
        countJson(to: json)
        // 객체 원본 출력하기
        convertString(to: json)
    }
    
    private static func convertString(to data:Jsonable) {
        print(data.generateData())
    }
    
    private static func countJson(to json:Jsonable){
        let (string,int,bool,object,array) = json.countData()
        
        let totalCount = string + int + bool + object + array
        var message = ""
        
        if json is JsonObject {
            message = "총 \(totalCount)개의 객체 데이터 중에 "
        }
        if json is JsonArray {
            message = "총 \(totalCount)개의 배열 데이터 중에 "
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
        print(message)
    }
}
