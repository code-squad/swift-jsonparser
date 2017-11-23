//
//  OutputView.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    enum OutputError: String, Error {
        case pathError = "파일 경로를 확인해주세요."
        case fileURLError = "파일 내용을 쓰는 데 실패했습니다."
    }
    
    static func writeData(_ prettyData: String, into outputFileName: String) throws {
        do {
            try prettyData.write(toFile: outputFileName, atomically: true, encoding: .utf8)
        }catch {
            throw OutputError.fileURLError
        }
    }
    
    // JSON 규격에 맞춰 예쁘게 출력.
    static func getPrettyData(_ data: JSONData) -> String {
        var resultData = ""
        for datum in data.prettyData {
            resultData += "\(datum) "
        }
        resultData += "\n"
        return resultData
    }
    
    // 내부 데이터 description 출력.
    static func getReport(_ data: JSONData) -> String {
        var dataType: String = ""
        // 전체 데이터 개수 (문자열, 숫자, 부울, 객체, 배열)
        let dataCounts = data.dataCountOfEach
        // 전체 데이터의 타입에 따른 분기. (가장 바깥쪽 데이터 타입)
        switch data {
        case is JSONArray: dataType = "배열"
        case is JSONObject: dataType = "객체"
        default: break
        }
        
        // 출력할 문자열.
        var result = "총 \(data.count)개의 \(dataType) 데이터 중에"
        if dataCounts.string > 0 {
            result += " 문자열 \(dataCounts.string)개,"
        }
        if dataCounts.number > 0 {
            result += " 숫자 \(dataCounts.number)개,"
        }
        if dataCounts.bool > 0 {
            result += " 부울 \(dataCounts.bool)개,"
        }
        if dataCounts.nestedObject > 0 {
            result += " 객체 \(dataCounts.nestedObject)개,"
        }
        if dataCounts.nestedArray > 0 {
            result += " 배열 \(dataCounts.nestedArray)개,"
        }
        result.removeLast()             // 마지막 콤마(,) 제거.
        result += "가 포함되어 있습니다."
        return result
    }
    
    // JSON 관련 에러 출력.
    static func printError(_ error: GrammarChecker.JsonError) {
        print(error.rawValue)
    }
    
}
