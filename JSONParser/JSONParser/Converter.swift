//
//  Converter.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/27/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Converter {
    static func stringToJson (_ valueEntered: String) -> [JsonType] {
        let input = valueEntered
        
        let InputSplited = splitInput(input)
        let json = JsonParser.parseJson(InputSplited)
        
        return json
    }
    
    static private func splitInput (_ input: String) ->  [String] {
        var inputSplited = input.components(separatedBy: [","])

        if inputSplited.first == "[" { inputSplited.removeFirst() }
        if inputSplited.last == "]" { inputSplited.removeLast() }
        
        inputSplited = inputSplited.filter( { (value: String) -> Bool in return (value != "") } )
        return inputSplited
    }
}
