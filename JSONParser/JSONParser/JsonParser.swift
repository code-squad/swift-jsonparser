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
            let elementsFromArray = RegexGrammar.elementsFromArray
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
            
        }
        
        return json
    }
    
    static private func elementToJsonType (_ element: String) -> JsonType {
        switch element.first {
        case "{":
        case "[":
        default:
        }
    }
    
    static private func elementToObject (_ element: String) -> JsonType {
        let colon = DevideCharacter.colon
        var elementSplited = element.components(separatedBy: String(colon.rawValue))
        element
        
        return
    }
    
    static private func elementToObjectElement (_ element: String) -> JsonType {
        
        
        return
    }
    
    static private func getObjectElement (_ input: String) -> (String, JsonType) {
        let colon = DevideCharacter.colon
        var inputSplited = input.components(separatedBy: String(colon.rawValue))
        
        inputSplited[0] = removeBlank(inputSplited[0], first: DevideCharacter.curlyBracketOpen, last: DevideCharacter.curlyBracketClose)
        inputSplited[1] = removeBlank(inputSplited[1], first: DevideCharacter.curlyBracketOpen, last: DevideCharacter.curlyBracketClose)
        
        return (inputSplited[0], getJsonValue(inputSplited[1]))
    }
    
    static private func getJsonValue (_ input: String) -> JsonType {
        if let number = Int(input) { return JsonType.int(number) }
        else if input == "true" { return JsonType.bool(true) }
        else if input == "false" { return JsonType.bool(false) }
        else { return JsonType.string(input) }
    }
   
    static private func removeBlank (_ input: String, first: DevideCharacter, last: DevideCharacter) -> String {
        let whiteSpace = DevideCharacter.whiteSpace
        var modifyInput = input
        
        if modifyInput.first == first.rawValue { modifyInput.removeFirst() }
        if modifyInput.first == whiteSpace.rawValue { modifyInput.removeFirst() }
        if modifyInput.last == last.rawValue { modifyInput.removeLast() }
        if modifyInput.last == whiteSpace.rawValue { modifyInput.removeLast() }
        
        return modifyInput
    }
}

