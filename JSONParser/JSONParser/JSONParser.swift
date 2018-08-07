//
//  JSONParser.swift
//  JSONParser
//
//  Created by 이동건 on 03/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    // JSON Parsed Result
    struct JSONParsedResult {
        private (set) var result: [String:String]
        
        init(results: [String:String]) {
            self.result = results
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
    // Parsing
    private static func parse(from elements : [String]) -> JSONParsedResult{
        // elements - ["asdf:123",  ... ]= []
        var parsedJSONObjects: [String:String] = [:]
        elements.forEach { (element) in
            let keyAndValue = element.split(separator: ":").map {String($0)}
            if keyAndValue.count != 2 { return }
            parsedJSONObjects[keyAndValue[0]] = keyAndValue[1]
        }
        return JSONParsedResult(results: parsedJSONObjects)
    }
}
