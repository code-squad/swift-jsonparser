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
    
    public static func printJson(from json:Jsonable){
        // 객체 데이터 종류 출력하기
        countJson(from: json)
        // 객체 원본 출력하기
        convertString(from: json)
    }
    
    private static func convertString(from data:Jsonable) {
        print(data.generateData())
    }
    
    private static func countJson(from data:Jsonable){
        print(data.countDataWithMessage())
    }
}
