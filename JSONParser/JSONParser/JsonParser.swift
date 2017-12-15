//
//  JsonParser.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JsonParser {
    func makeJsonData(jsonValue: String) throws -> Any {
        // scanner
        var tokenValues: [Token]
        let jsonScanner = JsonScanner()
        do {
            try tokenValues = jsonScanner.scanOfJsonValue(jsonValue: jsonValue)
        }catch {
            throw JsonScanner.JsonError.invalidJsonPattern
        }
        
        // json parser (checking json syntax)
        var jsonData: Any = ""
        guard let startOfToken: JsonScanner.regex = tokenValues[0].id else {
            throw JsonScanner.JsonError.invalidJsonPattern
        }
        if startOfToken == JsonScanner.regex.STARTSQUAREBRACKET {
            var arrayJsonParser = ArrayJsonParser()
            jsonData = arrayJsonParser.makeJsonData(token: tokenValues)

        }else if startOfToken == JsonScanner.regex.STARTCURLYBRACKET {
            var objectJsonParser = ObjectJsonParser()
            jsonData = objectJsonParser.makeJsonData(token: tokenValues)
        }else {
            print("JSON 데이터가 아님")
        }
        return jsonData
    }
    
}

