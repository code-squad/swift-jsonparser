//
//  jsonParser.swift
//  JSONParser
//
//  Created by 김장수 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    // 문자열을 파싱해서 각 데이터 형태에 맞게 프로토콜로 리턴
    func parse(from input: String) -> Parsable? {
        if input.isArray {
            guard let array = parseArray(of: input) else { return nil }
            return ArrayJSONData.init(elements: array)
        } else if input.isObject {
            guard let object = parseObject(of: input) else { return nil }
            return ObjectJSONData.init(elements: object)
        } else {
            return nil
        }
    }
    
    // 배열 파싱
    private func parseArray(of input: String) -> [JSONType]? {
        var jsonData = [JSONType]()
        let rawData = Regex(rawData: input).takeArray()
        
        rawData.forEach {
            jsonData.append(determineType(of: $0)!)
        }
        return jsonData
    }
    
    // 객체 파싱
    private func parseObject(of input: String) -> [String: JSONType]? {
        var jsonData = [String: JSONType]()
        let rawData = Regex(rawData: input).takeObject()
        
        rawData.forEach {
            let data = $0.split(separator: ":").map { $0.trimmingCharacters(in: CharacterSet(charactersIn: " ")) }
            jsonData[data[0]] = determineType(of: data[1])
        }
        return jsonData
    }
    
    // 해당하는 데이터 타입 결정
    private func determineType(of element: String) -> JSONType? {
        if element.isNumeric { return JSONType.int(Int(element)!) }
        if element.isBoolean { return JSONType.bool(Bool(element)!) }
        if element.isString { return JSONType.string(element) }
        if element.isArray { return JSONType.array(ArrayJSONData(elements: parseArray(of: element)!)) }
        if element.isObject { return JSONType.object(ObjectJSONData(elements: parseObject(of: element)!)) }
        return nil
    }
}
