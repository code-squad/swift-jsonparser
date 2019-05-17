//
//  JsonParser.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/29/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonParser {
    //정규표현식에 해당하는 문자열 배열 리턴
    static private func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    static func parseJson (_ input: String) -> [JsonType] {
        let devideCharacter = DevideCharacter(rawValue: input.first!) ?? .colon
        let elements: [String]
        
        if devideCharacter == DevideCharacter.squareBracketOpen {
            let elementsFromArray = RegexGrammar.elementsFromArrayInArray
            elements = matches(for: elementsFromArray.rawValue, in: input)
        } else {
            let elementsFromObject = RegexGrammar.elementsFromObject
            elements = matches(for: elementsFromObject.rawValue, in: input)
        }
        
        let json = elementsToJson(elements)
        
        return json
    }
    
    static private func elementsToJson (_ elements: [String]) -> [JsonType] {
        var json = [JsonType]()
        
        for element in elements {
            json.append(elementToJsonType(element))
        }
        
        return json
    }
    
    static private func elementToJsonType (_ element: String) -> JsonType {
        switch element.first {
        case "{": return JsonType.object(elementToObject(element))
        case "[": return JsonType.array(elementToArray(element))
        default: return getJsonValue(element)
        }
    }
    
    static private func elementToObject (_ element: String) -> [String:JsonType] {
        var jsonObject = [String:JsonType]()
        let elementsFromObject = RegexGrammar.elementsFromArrayInArray
        let elements = matches(for: element, in: elementsFromObject.rawValue)
        let colon = DevideCharacter.colon
        var elementSplited: [String]
    
        for element in elements {
            elementSplited = element.components(separatedBy: String(colon.rawValue))
            elementSplited[0].removeFirst()
            elementSplited[0].removeLast()
            elementSplited[1].removeFirst()
            jsonObject[elementSplited[0]] = getJsonValue(elementSplited[1])
        }
        
        return jsonObject
    }
    
    static private func elementToArray (_ element: String) -> [JsonType] {
        var jsonArray = [JsonType]()
        let elementsFromArray = RegexGrammar.elementsFromObject
        let elements = matches(for: element, in: elementsFromArray.rawValue)
    
        for element in elements {
            jsonArray.append(getJsonValue(element))
        }
        
        return jsonArray
    }
    
//    static private func getObjectElement (_ input: String) -> (String, JsonType) {
//        let colon = DevideCharacter.colon
//        var inputSplited = input.components(separatedBy: String(colon.rawValue))
//
//        inputSplited[0] = removeBlank(inputSplited[0], first: DevideCharacter.curlyBracketOpen, last: DevideCharacter.curlyBracketClose)
//        inputSplited[1] = removeBlank(inputSplited[1], first: DevideCharacter.curlyBracketOpen, last: DevideCharacter.curlyBracketClose)
//
//        return (inputSplited[0], getJsonValue(inputSplited[1]))
//    }
    
    static private func getJsonValue (_ input: String) -> JsonType {
        if let number = Int(input) { return JsonType.int(number) }
        else if input == "true" { return JsonType.bool(true) }
        else if input == "false" { return JsonType.bool(false) }
        else { return JsonType.string(input) }
    }
}

