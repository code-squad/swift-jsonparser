//
//  JsonParser.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/29/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonParser {
    static func parseJson (_ inputSplited: [String]) -> [JsonType] {
        var json = [JsonType]()
        var object = [String: JsonType]()
        var array = [JsonType]()
        var key: String
        var value: JsonType
        var modifyInput: String
        var firstDevideCharacter: DevideCharacter
        var lastDevideCharacter: DevideCharacter
        
        for inputValue in inputSplited {
            modifyInput = removeBlank(inputValue, first: DevideCharacter.squareBracketOpen, last: DevideCharacter.squareBracketClose)
            firstDevideCharacter = DevideCharacter(rawValue: modifyInput.first!) ?? .colon
            lastDevideCharacter = DevideCharacter(rawValue: modifyInput.last!) ?? .colon
            if firstDevideCharacter == DevideCharacter.squareBracketOpen || array.count > 0 {
                array.append(getJsonValue(modifyInput))
            } else if firstDevideCharacter == DevideCharacter.curlyBracketOpen || object.count > 0 {
                (key, value) = getObjectElement(modifyInput)
                object[key] = value
            } else {
                json.append(getJsonValue(modifyInput))
            }
            if lastDevideCharacter == DevideCharacter.curlyBracketClose {
                json.append(JsonType.object(object))
                object.removeAll()
            }
            if lastDevideCharacter == DevideCharacter.squareBracketClose {
                json.append(JsonType.array(array))
                array.removeAll()
            }
        }
        
        return json
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

