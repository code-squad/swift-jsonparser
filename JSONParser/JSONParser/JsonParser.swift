//
//  JsonParser.swift
//  JSONParser
//
//  Created by jang gukjin on 02/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonParser {
    func distinctArray(inputdata: String?) throws -> String {
        guard let input : String = inputdata, input.first == "[", input.last == "]" else { throw ErrorMessage.notArray }
        return input
    }
    
    func parsingData(beforeData : String) throws -> [Json]{
        var jsonDatas : [Json] = []
        var convertedElement : ElementType
        var datas = beforeData
        datas.removeFirst()
        datas.removeLast()
        let refinedData = datas.components(separatedBy: ",").filter { $0 != "" }
        for dataElement in refinedData {
            if dataElement.contains("\"") { convertedElement = TypeString.init(json: dataElement) }
            else if let _ = Int(dataElement) { convertedElement = TypeInt.init(json: dataElement) }
            else if let _ = Bool(dataElement) { convertedElement = TypeBool.init(json: dataElement) }
            else { throw ErrorMessage.wrongValue }
            let jsonData = Json.init(json: convertedElement)
            jsonDatas.append(jsonData)
        }
        return jsonDatas
    }
}
