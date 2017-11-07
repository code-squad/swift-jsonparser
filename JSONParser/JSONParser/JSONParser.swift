//
//  JSONParser.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    enum JsonError: String, Error {
        case invalidPattern = "JSON 규격에 맞게 입력해주세요."
    }
    
    static func parse(from rawData: String) -> JSONData {
        let searchedData = searchJsonData(from: rawData)
        var stringData: [String] = []
        var numberData: [JSONData.Number] = []
        var boolData: [Bool] = []
        searchedData.map {
            if $0.contains("\"") {
                stringData.append($0.trimmingCharacters(in: ["\""]))
            }else if let numberElement = JSONData.Number($0) {
                numberData.append(numberElement)
            }else if let boolElement = Bool($0){
                boolData.append(boolElement)
            }
        }
        return JSONData(string: stringData, number: numberData, bool: boolData)
    }
    
    static func searchJsonData(from rawData: String) -> [String] {
        return rawData.trimmingCharacters(in: ["[", "]"]).split(separator: ",").map{ $0.trimmingCharacters(in: .whitespaces) }
    }
    
}

