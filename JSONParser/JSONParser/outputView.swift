//
//  OutputView.swift
//  JSONParser
//
//  Created by 김장수 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum JSONType: String {
    case int = "숫자"
    case bool = "부울"
    case object = "객체"
    case string = "문자열"
}

struct OutputView {
    // JSONParser에서 전달받은 데이터 세트를 출력
    func printResult(by data: Parsable) {
        var dataType = String()
        let result = checkType(of: data.getDTO())
        
        if data is ArrayJSONData { dataType = "배열" }
        if data is ObjectJSONData { dataType = "객체" }
        
        print("총 \(result.n)개의 \(dataType) 데이터 중에 \(result.ment)가 포함되어 있습니다.")
    }
    
    private func checkType(of data: DTO) -> (n: Int, ment: String) {
        let total = data.json.count
        var int = Int(), bool = Int(), string = Int(), object = Int()
        
        for element in data.json {
            if element.isNumeric { int += 1 }
            if element.isBoolean { bool += 1 }
            if element.isString { string += 1 }
            if element.isObject { object += 1 }
        }
        
        let mention = makeMent(by: int, bool, string, object)
        
        return (n: total, ment: mention)
    }
    
    private func makeMent(by int: Int, _ bool: Int, _ string: Int, _ object: Int) -> String {
        var ments = [String]()
        
        if int > 0 { ments.append("\(JSONType.int.rawValue) \(int)개") }
        if bool > 0 { ments.append("\(JSONType.bool.rawValue) \(bool)개") }
        if string > 0 { ments.append("\(JSONType.string.rawValue) \(string)개") }
        if object > 0 { ments.append("\(JSONType.object.rawValue) \(object)개") }
        
        return ments.joined(separator: ", ")
    }
}
