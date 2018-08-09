//
//  JSONParser.swift
//  JSONParser
//
//  Created by 이동건 on 03/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol JSONElementProtocol {
    var value: AvailableJSONType {get}
}

extension String {
    var actualValue: JSONElementProtocol? {
        switch self {
        case let value where value.contains("\""): return value
        case let value where Int(value) != nil : return Int(value)
        case let value where Bool(value) != nil : return Bool(value)
        default: return nil
        }
    }
}
extension String: JSONElementProtocol {
    var value: AvailableJSONType {
        return .string
    }
}
extension Int: JSONElementProtocol {
    var value: AvailableJSONType {
        return .int
    }
}
extension Bool: JSONElementProtocol {
    var value: AvailableJSONType {
        return .bool
    }
}
extension Dictionary: JSONElementProtocol where Key == String, Value == JSONElementProtocol {
    var value: AvailableJSONType {
        return self.values.first!.value
    }
}

struct JSONParser {
    // JSON Parsed Result
    struct JSONParsedResult {
        var results: [JSONElementProtocol]
        
        init(results: [JSONElementProtocol]) {
            self.results = results
        }
    }
    
    // 사용자 인풋으로부터 시작하는 메소드
    static func result(from data: String) -> [JSONParsedResult] {
        let objects = generateObjects(from: data)
        return objects.map {parse(from: removeAccessory(from: $0))}
    }
    
    // MARK: 배열 속 JSON 객체를 추출
    // Remove Accessory
    private static func generateObjects(from data: String) -> [String] { // "[{..}, {..}]" ---> ["{..}", "{..}"]
        var target = data
        target = target.replacingOccurrences(of: " ", with: "")
        target = target.replacingOccurrences(of: "[", with: "")
        target = target.replacingOccurrences(of: "]", with: "")
        return splitByObject(from: target)
    }
    // Split
    private static func splitByObject(from data: String) -> [String] { // "{...},{...},{...}" ---> ["{...}", "{...}", "{...}"]
        var target = data.components(separatedBy: "},{")
        
        if target.count == 1 {
            return target
        }
        
        target.enumerated().forEach {
            $0.offset % 2 == 0 ? target[$0.offset].insert("}", at: target[$0.offset].endIndex) : target[$0.offset].insert("{", at: target[$0.offset].startIndex)
        }
        return target
    }
    
    //MARK: JSON 객체로부터 키-값 추출
    // Remove Accessory
    private static func removeAccessory(from data: String) -> [String] {
        var target = data
        target = target.replacingOccurrences(of: "{", with: "")
        target = target.replacingOccurrences(of: "}", with: "")
        return target.split(separator: ",").map {String($0)}
    }
    
    //MARK: Parsing
    private static func parse(from elements : [String]) -> JSONParsedResult{
        var results: [JSONElementProtocol] = []
        elements.forEach { (element) in
            if !element.contains(":") {
                if let value = element.actualValue {
                    results.append(value) // 단순 값의 나열에 해당하는 요소
                }
                return
            }
            let rawPair = element.split(separator: ":").map {String($0)}
            if let value = rawPair[1].actualValue {
                let pair = [rawPair[0]:value]
                results.append(pair)
            }
        }
        return JSONParsedResult(results: results)
    }
}
