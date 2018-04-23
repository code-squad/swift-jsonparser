//
//  TypeMatching.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 4. 23..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct Json {
    
    typealias JSONDataSaveFormat = (numbers: Array<Int>, strings: Array<String>, booleans: Array<Bool>)
    static var jsonDataModel = JSONDataSaveFormat([],[],[])
    
    static func get(_ anyType: Any ) throws -> JSONData {
        var jsonData: JSONData
        switch anyType {
            case let rawArray as Array<Any>:
                jsonData = try getJsonData(rawArray)
        default:
            throw JSONPaserErorr.isNil
        }
        return jsonData
    }
    
    static func getJsonData(_ rawArray: Array<Any>) throws -> JSONData {
        for anyValue in rawArray {
            switch anyValue {
                case let rawString as String :
                    jsonDataModel.strings.append(rawString)
                case let rawInt as Int :
                    jsonDataModel.numbers.append(rawInt)
                case let rawBool as Bool :
                    jsonDataModel.booleans.append(rawBool)
            default:
                throw JSONPaserErorr.isNil
            }
        }
        return JSONData(jsonDataModel.strings, jsonDataModel.numbers, jsonDataModel.booleans)
    }
}
