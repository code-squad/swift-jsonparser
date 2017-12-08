//
//  JsonParser.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JsonTypeCounter {
    
    func countDataType(stack: JsonStack, kindOf: String) throws -> DataInfo {
        var jsonData = [String:Any]()
        var dataInfo = DataInfo()
        dataInfo.type = kindOf
        var jsonStack = stack
        var value: Any = ""
        var key: String = ""
        var isObject = false
        
        if kindOf == "객체" {
            while jsonStack.size > 0 {
                let data = try jsonStack.pop()
                if data.id == JsonScanner.regex.ENDCURLYBRACKET || data.id == JsonScanner.regex.COMMA {
                    value = try jsonStack.peek().value
                    let stackId = try jsonStack.peek().id
                    if stackId == JsonScanner.regex.NUMBER {
                        dataInfo.countOfNumber += 1
                    }
                    if stackId == JsonScanner.regex.STRING {
                        dataInfo.countOfString += 1
                    }
                    if stackId == JsonScanner.regex.BOOLEAN {
                        dataInfo.countOfBool += 1
                    }
                }else if data.id == JsonScanner.regex.COLON {
                    key = try jsonStack.peek().value
                    jsonData[key] = value
                }
            }
        }else if kindOf == "배열" {
            while jsonStack.size > 0 {
                let data = try jsonStack.pop()
                if data.id == JsonScanner.regex.ENDCURLYBRACKET {
                    isObject = true
                }else if data.id == JsonScanner.regex.STARTCURLYBRACKET {
                    isObject = false
                    dataInfo.countOfObject += 1
                }
            }
        }

        return dataInfo
    }
    
}
