//
//  JsonParser.swift
//  JSONParser
//
//  Created by jang gukjin on 02/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonParser {
    /// 입력받은 String의 양끝에 "[","]"가 있는지 판단하는 함수
    func distinctArray(inputdata: String?) throws -> String {
        guard let input : String = inputdata, input.first == "[", input.last == "]" else { throw ErrorMessage.notArray }
        return input
    }
    /// 배열 내의 원소가 어떤 타입인지 판단하고 [Json] 타입의 배열을 재생성하는 함수
    func parsingData(beforeData : String) throws -> [Json] {
        var jsonData : [Json] = []
        var convertedElement : Json
        var data = beforeData
        data.removeFirst()
        data.removeLast()
        let refinedData = data.components(separatedBy: ",").filter { $0 != "" }
        for dataElement in refinedData {
            if dataElement.contains("\"") { convertedElement = TypeString.init(json: dataElement) }
            else if let _ = Int(dataElement) { convertedElement = TypeInt.init(json: dataElement) }
            else if let _ = Bool(dataElement) { convertedElement = TypeBool.init(json: dataElement) }
            else { throw ErrorMessage.wrongValue }
            jsonData.append(convertedElement)
        }
        return jsonData
    }
}
