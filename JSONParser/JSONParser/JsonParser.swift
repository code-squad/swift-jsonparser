//
//  JsonParser.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/29/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonParser {
    static func makeJson (_ inputSplited: [String]) -> [JsonType] {
        var json = [JsonType]()
        var object = [String: JsonType]()
        var key: String
        var value: JsonType
        var modifyInput: String
        
        for inputValue in inputSplited {
            modifyInput = removeBlank(inputValue)
            
            if modifyInput.first == "{" || object.count > 0 {
                (key, value) = getObjectElement(modifyInput)
                object[key] = value
            } else if modifyInput.last == "}" {
                (key, value) = getObjectElement(modifyInput)
                object[key] = value
                json.append(JsonType.object(object))
                object.removeAll()
            } else {
                json.append(getJsonValue(modifyInput))
            }
        }
        
        return json
    }
    
    static private func getObjectElement (_ input: String) -> (String, JsonType) {
        var inputSplited = input.components(separatedBy: [":"])
        
        if inputSplited[0].first == "{" { inputSplited[0].removeFirst() }
        if inputSplited[0].first == " " { inputSplited[0].removeFirst() }
        if inputSplited[0].last == " " { inputSplited[0].removeLast() }
        if inputSplited[1].first == " " { inputSplited[1].removeFirst() }
        if inputSplited[1].last == "}" { inputSplited[1].removeLast() }
        if inputSplited[1].last == " " { inputSplited[1].removeLast() }
        
        return (inputSplited[0], getJsonValue(inputSplited[1]))
    }
    
    static private func getJsonValue (_ input: String) -> JsonType {
        if let number = Int(input) { return JsonType.int(number) }
        else if input == "true" { return JsonType.bool(true) }
        else if input == "false" { return JsonType.bool(false) }
        else { return JsonType.string(input) }
    }
   
    static private func removeBlank (_ input: String) -> String {
        var modifyInput = input
        
        if modifyInput.first == "[" { modifyInput.removeFirst() }
        if modifyInput.first == " " { modifyInput.removeFirst() }
        if modifyInput.last == "]" { modifyInput.removeLast() }
        if modifyInput.last == " " { modifyInput.removeLast() }
        
        return modifyInput
    }
}

