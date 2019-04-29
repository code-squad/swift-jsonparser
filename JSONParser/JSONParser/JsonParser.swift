//
//  JsonParser.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/29/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonParser {
    static private func makeJson (_ inputSplited: [String]) -> [Any] {
        var json = [JsonType]()
        
        for inputValue in inputSplited {
            if let number = Int(inputValue) {
                json.append(JsonType.int(number))
            } else if inputValue == "true" {
                json.append(JsonType.bool(true))
            } else if inputValue == "false" {
                json.append(JsonType.bool(false))
            } else {
                json.append(JsonType.string(inputValue))
            }
        }
        
        return json
    }
}

