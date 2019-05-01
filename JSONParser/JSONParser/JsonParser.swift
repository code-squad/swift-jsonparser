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
        
        for inputValue in inputSplited {
            if inputValue.first == "{" || object.count > 0 || inputValue.last == "}" {
                (key, value) = getObjectElement(inputValue)
                object[key] = value
                
                if inputValue.last == "}" {
                    json.append(JsonType.object(object))
                    object.removeAll()
                }
            } else {
                json.append(getJsonValue(inputValue))
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
        if let number = Int(input) {
             return JsonType.int(number)
        } else if input == "true" {
            return JsonType.bool(true)
        } else if input == "false" {
            return JsonType.bool(false)
        } else {
            return JsonType.string(input)
        }
    }
   
}

