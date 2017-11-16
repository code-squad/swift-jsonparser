//
//  JSONAnalyser.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONAnalyser {
    private let grammarChecker : GrammarChecker

    init(grammarChecker: GrammarChecker) {
        self.grammarChecker = grammarChecker
    }

    func getJSONData(inputValue: String) -> JSONData {
        var typedArray : JSONData = []
        let elements: Array<String> = getElementsAll(from: inputValue)
        for element in elements {
            typedArray.append(setEachType(element: element) ?? "")
        }
        return typedArray
    }
    
    private func setEachType(element: String) -> Any? {
        if element.starts(with: "{") {
            return getJSONObject(elements: getObjectElements(from: element))
        } else if element.starts(with: "[") {
            return getJSONData(inputValue: element)
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
        var jsonObject : JSONObject = [:]
        for element in elements {
            let keyValue = element.split(separator: ":").map {$0.trimmingCharacters(in: .whitespaces)}
            let key : String = String(keyValue[0]).replacingOccurrences(of: "\"", with: "")
            let value : Any = setEachType(element: String(keyValue[1])) ?? ""
            jsonObject[key] = value
        }
        return jsonObject
    }

    private func getElementsAll(from target: String) -> Array<String> {
        var result : Array<String> = []
        if target.starts(with: "{") {
            result.append(target)
        } else {
            result.append(contentsOf: getElementsFromArray(with: target))
        }
        return result
    }

    private func getElements(from target: String) -> Array<String> {
        return target.split(separator: ",").flatMap {$0.trimmingCharacters(in: .whitespaces)}
    }

    private func getElementsFromArray(with target: String) -> Array<String> {
        var elementsFromArray : Array<String> = []
        var elements : String = target.trimmingCharacters(in: ["[","]"])
        elementsFromArray.append(contentsOf: grammarChecker.getArrayMatches(from: elements))
        elements = grammarChecker.removeMatchedArray(target: elements)
        elementsFromArray.append(contentsOf: grammarChecker.getObjectMatches(from: elements))
        elements = grammarChecker.removeMatchedObject(target: elements)
        elementsFromArray.append(contentsOf: getElements(from: elements))
        return elementsFromArray
    }

    private func getObjectElements(from target: String) -> Array<String> {
        return grammarChecker.getObjectElements(from: target)
    }

}
