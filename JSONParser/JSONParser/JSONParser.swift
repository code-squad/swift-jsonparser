//
//  JSONParser.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 13..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    
    func makeJSONData(_ value: String) throws -> JSONData {
        guard GrammarChecker.checkFirstObjectJSON(of: value) else {
            throw ErrorCode.invalidJSONStandard
        }
        if value.hasPrefix("[") {
            return try JSONArray.makeJSONFirstObjectData(value)
        }
        if value.hasPrefix("{") {
            return try JSONObject.makeJSONFirstObjectData(value)
        }
        throw ErrorCode.invalidJSONStandard
    }
    
}

extension String {
    
    func removeFirstAndEnd() -> String {
        var rawJSON = self
        rawJSON.removeFirst()
        rawJSON.removeLast()
        return rawJSON
    }
    
}
