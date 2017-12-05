//
//  SplitInput.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 5..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct ValueProducer {

    func makeInputIntoList (_ input: String?) -> [String] {
        var stringValuesList : [String] = []
        guard let inputValue = input else {return []}
        
        if inputValue.hasPrefix("[") && inputValue.hasSuffix("]") {
            let trimmedValue = inputValue.trimmingCharacters(in: ["[","]"])
            let valuesList = trimmedValue.split(separator: ",")
            stringValuesList = valuesList.map({(value:String.SubSequence)->String in String(value).trimmingCharacters(in: .whitespacesAndNewlines)})
        }

        return stringValuesList
    }

}
