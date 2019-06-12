//
//  JsonValues.swift
//  JSONParser
//
//  Created by hw on 12/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

extension String : JsonParsable {
    var description : String {
        get {
            return self
        }
    }
}

extension Int : JsonParsable {
    var description : String {
        get {
            return String(self)
        }
    }
}

extension Bool : JsonParsable {
    var description : String {
        get {
            return String(self)
        }
    }
}

extension Array: JsonParsable {
    var description : String {
        get{
            var result = "\(TokenSplitSign.squareBracketStart.description) "
            for index in 0..<self.count-1{
                guard let jsonElement = self[index] as? JsonParsable else {
                    return result
                }
                result += " \(jsonElement.self.description),"
            }
            result.popLast()
            result += " \(TokenSplitSign.squareBracketEnd.description)"
            return result
        }
    }
}
