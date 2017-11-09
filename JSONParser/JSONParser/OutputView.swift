//
//  OutputView.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    static func printDataReport(of jsonDatas: [JSONData]) {
        // 데이터 blob이 1개밖에 없으면 세부 레포트를 하고, 2개 이상이면 전체 레포트를 한다.
        let report = jsonDatas.count == 1 ? getSpecificReport(of: jsonDatas[0]) : getOverallReport(of: jsonDatas)
        print(report)
    }
    
    // 전체 레포트
    private static func getOverallReport(of jsonDatas: [JSONData]) -> String {
        var numberOfObjects = 0
        var numberOfArrays = 0
        var message = "총 \(jsonDatas.count)개의 배열 데이터 중에 "
        for jsonData in jsonDatas {
            switch jsonData.type {
            case .object: numberOfObjects += 1
            case .array: numberOfArrays += 1
            }
        }
        if numberOfObjects > 0 {
            message += "객체 \(numberOfObjects)개와 "
        }
        if numberOfArrays > 0 {
            message += "배열 \(numberOfArrays)개"
        }
        message += "가 포함되어 있습니다."
        return message
    }
    
    // 세부 레포트
    private static func getSpecificReport(of data: JSONData) -> String {
        var result = "총 \(data.count)개의 데이터 중에"
        if data.string.count > 0 {
            result += " 문자열 \(data.string.count)개,"
        }
        if data.number.count > 0 {
            result += " 숫자 \(data.number.count)개,"
        }
        if data.bool.count > 0 {
            result += " 부울 \(data.bool.count)개,"
        }
        result.removeLast()
        result += "가 포함되어 있습니다."
        return result
    }
    
    static func printError(_ error: JSONParser.JsonError) {
        print(error.rawValue)
    }
    
}

