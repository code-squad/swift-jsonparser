//
//  JSONAnalyser.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONAnalyser {

    func getJSONType(inputValue: String) -> JSONType {
        if inputValue.starts(with: "{") {
            return getJSONObject(elements: getObjectElements(from: inputValue))
        } else {
            return getJSONArray(elements: getElementsFromArray(with: inputValue))
        }
    }
    
    private func setEachType(element: String) -> Any? {
        if element.starts(with: "{") {
            return getJSONObject(elements: getObjectElements(from: element))
        } else if element.starts(with: "[") {
            return getJSONArray(elements: getElementsFromArray(with: element.trimmingCharacters(in: ["[","]"])))
        } else if element.starts(with: "\"") {
            return element.replacingOccurrences(of: "\"", with: "")
        } else if let element = Int(element) {
            return element as Int
        } else if let element = Bool(element) {
            return element as Bool
        }
        return nil
    }
    
    private func getJSONObject(elements: Array<String>) -> JSONObject {
        var jsonObject : JSONObject = JSONObject()
        for element in elements {
            let keyValue = element.split(separator: ":")
                                  .map {$0.trimmingCharacters(in: .whitespaces)}
            let key : String = String(keyValue[0]).replacingOccurrences(of: "\"", with: "")
            let value : Any = setEachType(element: String(keyValue[1])) ?? ""
            jsonObject.add(key: key, value: value)
        }
        return jsonObject
    }

    private func getJSONArray(elements: Array<String>) -> JSONArray {
        var jsonArray: JSONArray = JSONArray()
        for element in elements {
            jsonArray.add(element: (setEachType(element: element) ?? ""))
        }
        return jsonArray
    }

    private func getElementsFromArray(with target: String) -> Array<String> {
        var elementsFromArray : Array<String> = []
        var elements : String = target
        if grammarChecker.isInsideArrayPattern(target: elements) {
            elementsFromArray.append(contentsOf: getArrayMatches(from: elements))
            elements = removeMatchedArray(target: elements)
            elementsFromArray.append(contentsOf: getObjectMatches(from: elements))
            elements = removeMatchedObject(target: elements)
        }
        elementsFromArray.append(contentsOf: getElements(from: elements))
        return elementsFromArray
    }

}

private typealias JSONElementsPicker = JSONAnalyser

private extension JSONElementsPicker {
    
    // 배열, 객체 외의 데이터 추출
    func getElements(from target: String) -> Array<String> {
        return target.trimmingCharacters(in: ["[","]"]).split(separator: ",").flatMap {$0.trimmingCharacters(in: .whitespaces)}
    }

    // 배열 내부의 배열 추출
    func getArrayMatches(from target: String) -> Array<String> {
        return getMatchedElements(from: target, with: JSONPatterns.arrayPattern)
    }

    // 배열 내부의 객체 추출
    func getObjectMatches(from target: String) -> Array<String> {
        return getMatchedElements(from: target, with: JSONPatterns.objectPattern)
    }

    // JSONObject 타입에서 요소 추출
    func getObjectElements(from target: String) -> Array<String> {
        return getMatchedElements(from: target, with: JSONPatterns.nestedDictionaryPattern)
    }

    func getMatchedElements(from target: String, with pattern: String) -> Array<String> {
        let regularExpression = try! NSRegularExpression.init(pattern: pattern, options: [])
        let objectResult = regularExpression.matches(in: target, options: [], range: NSRange(location:0, length:target.count))
        let result = objectResult.map {String(target[Range($0.range, in: target)!]).trimmingCharacters(in: .whitespaces)}
        return result
    }

    func removeMatchedArray(target: String) -> String {
        return removeMatchedElements(from: target, with: JSONPatterns.arrayPattern)
    }

    func removeMatchedObject(target: String) -> String {
        return removeMatchedElements(from: target, with: JSONPatterns.objectPattern)
    }

    func removeMatchedElements(from target: String, with pattern: String) -> String {
        let regularExpression = try! NSRegularExpression.init(pattern: pattern, options: [])
        let result = regularExpression.stringByReplacingMatches(in: target, options: [], range: NSRange(location:0, length: target.count), withTemplate: "")
        return result
    }
    
}
