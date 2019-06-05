//
//  Parser.swift
//  JSONParser
//
//  Created by hw on 24/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Parser {
    
    private var tokenizer: Tokenizer = Tokenizer()
    
    func parse(_ tokenList: [String] ) -> JsonParsable {
        var result : JsonParsable = ""
        if isJsonObject(tokenList) {
            result = makeJsonObject(tokenList)
            return result
        }
        if isJsonArray(tokenList) {
            result = makeJsonArray(tokenList)
        }
        return result
    }
    
    private func isJsonObject(_ tokenList : [String])-> Bool {
        if TokenSplitSign.curlyBracketStart.isEqualToBracket(tokenList[0]) && TokenSplitSign.curlyBracketEnd.isEqualToBracket(tokenList[tokenList.count-1]) {
            return true
        }
        return false
    }
    
    private func isJsonArray(_ tokenList : [String])-> Bool {
        if TokenSplitSign.squareBracketStart.isEqualToBracket(tokenList[0]) && TokenSplitSign.squareBracketEnd.isEqualToBracket(tokenList[tokenList.count-1]){
            return true
        }
        return false
    }
    
    private func makeJsonArray(_ tokenList: [String] ) -> JsonParsable {
        var jsonArray = [JsonParsable]()
        var index = 0
        while index < tokenList.count {
            index += 1
            if index == tokenList.count {
                break
            }
            if tokenList[index] == TokenSplitSign.comma.description ||
                tokenList[index] == TokenSplitSign.squareBracketEnd.description {
                continue
            }
            let value = confirmJsonValueType(tokenList: tokenList, index: &index)
            jsonArray.append(value)
            continue
        }
        return jsonArray
    }
    
    private func confirmJsonValueType(tokenList: [String], index: inout Int) -> JsonParsable {
        if TokenSplitSign.squareBracketStart.isEqualToBracket(tokenList[index]){
            let recursiveJsonArrayElement = saveJsonArrayElementInJsonArray(tokenList: tokenList, index: &index)
            return recursiveJsonArrayElement
        }
        if TokenSplitSign.curlyBracketStart.isEqualToBracket(tokenList[index]){
            let recursiveJsonObjectElement = saveJsonObjectElementInJsonArray(tokenList: tokenList, index: &index)
            return recursiveJsonObjectElement
        }
        
        let dataTypeCheck = isCastableValue(value: tokenList[index])
        switch dataTypeCheck {
        case .castIntSuccess(let intValue):
            return intValue
        case .castBoolSuccess(let boolValue):
            return boolValue
        case .defaultStringDataType(_):
            break
        }
        return tokenList[index]
    }
    
    private func makeJsonObject(_ tokenList: [String]) -> JsonParsable {
        var jsonObject: JsonObject = JsonObject()
        var index = 0
        while index < tokenList.count {
            index += 1
            if index >= tokenList.count {
                break
            }
            if tokenList[index] == TokenSplitSign.comma.description {
                continue
            }
            if tokenList[index] == TokenSplitSign.semicolon.description {
                /// find key : value
                let key = getKeyValueFromTokenizedJsonObject(tokenList: tokenList, index: index)
                index = index + 1
                let jsonObjectElement = confirmJsonValueType(tokenList: tokenList, index: &index)
                jsonObject.add(key: key, value: jsonObjectElement )
            }
        }
        return jsonObject
    }
    
    
    private func saveJsonObjectElementInJsonObject(tokenList : [String], index: inout Int) -> JsonParsable  {
        var (stackForObject, innerIndex) = buildStackForNestedElement(tokenList: tokenList, index: index, start : TokenSplitSign.curlyBracketStart.isEqualToBracket, end : TokenSplitSign.curlyBracketEnd.isEqualToBracket)
        let recursiveJsonObjectElement = buildRecursivlyFromStackToJsonElement(stackForObject: &stackForObject, recursiveFunction: makeJsonObject)
        index = innerIndex
        return recursiveJsonObjectElement
    }
    
    private func saveJsonArrayElementInJsonObject(tokenList : [String], index: inout Int) -> JsonParsable{
        var (stackForArray, innerIndex) = buildStackForNestedElement(tokenList: tokenList, index: index, start: TokenSplitSign.squareBracketStart.isEqualToBracket, end: TokenSplitSign.squareBracketEnd.isEqualToBracket)
        let recursiveJsonArrayElement = buildRecursivlyFromStackToJsonElement(stackForObject: &stackForArray, recursiveFunction: makeJsonArray)
        index = innerIndex
        return recursiveJsonArrayElement
    }
    
    private func getKeyValueFromTokenizedJsonObject(tokenList: [String], index: Int) -> String {
        let key = tokenList[index-1]
        return key
    }
    
    private func buildRecursivlyFromStackToJsonElement (stackForObject : inout Stack<String>, recursiveFunction: ([String]) -> JsonParsable ) -> JsonParsable {
        let allStackElement = makeStringFromStack(&stackForObject)
        //recursive logic
        let jsonElement = tokenizer.tokenize(allStackElement)
        let recursiveJsonParsableElement = recursiveFunction(jsonElement)
        return recursiveJsonParsableElement
    }
    
    private func buildStackForNestedElement (tokenList: [String], index: Int, start: (String) -> Bool , end: (String) -> Bool ) -> (Stack<String>, innerIndex: Int) {
        var stackForNestedElement : Stack<String> = Stack<String>()
        stackForNestedElement.push(tokenList[index])
        var innerIndex = index + 1
        var bracketCnt : Int = 1
        while (bracketCnt != 0 ){
            if start(tokenList[innerIndex]){
                bracketCnt += 1
            }else if end(tokenList[innerIndex]) {
                bracketCnt -= 1
            }
            stackForNestedElement.push(tokenList[innerIndex])
            innerIndex += 1
        }
        return (stackForNestedElement, innerIndex)
    }
    
    private func saveJsonArrayElementInJsonArray(tokenList : [String], index: inout Int) -> JsonParsable{
        var (stackForArray, innerIndex) = buildStackForNestedElement(tokenList: tokenList, index: index, start : TokenSplitSign.squareBracketStart.isEqualToBracket, end : TokenSplitSign.squareBracketEnd.isEqualToBracket)
        let recursiveJsonArrayElement = buildRecursivlyFromStackToJsonElement(stackForObject: &stackForArray, recursiveFunction: makeJsonArray)
        index = innerIndex
        return recursiveJsonArrayElement
    }
    
    private func saveJsonObjectElementInJsonArray(tokenList : [String], index: inout Int) -> JsonParsable {
        var (stackForArray, innerIndex) = buildStackForNestedElement(tokenList: tokenList, index: index, start : TokenSplitSign.curlyBracketStart.isEqualToBracket, end : TokenSplitSign.curlyBracketEnd.isEqualToBracket)
        let recursiveJsonObjectElement = buildRecursivlyFromStackToJsonElement(stackForObject: &stackForArray, recursiveFunction: makeJsonObject)
        index = innerIndex
        return recursiveJsonObjectElement
    }

    private func isCastableValue(value: String) -> Result<JsonParsable> {
        if let intValue = Int(value) {
            return .castIntSuccess(intValue)
        }
        return .defaultStringDataType(value)
    }
    
    private func makeStringFromStack (_ stack: inout Stack<String> ) -> String {
        var result = ""
        while !stack.isEmpty(){
            guard let currentValue = stack.pop()else {
                break
            }
            result = currentValue + TokenSplitSign.whitespace.description + result
        }
        return result
    }
    
    private func isString (_ token : String) -> Bool {
        return token.hasPrefix(TokenSplitSign.quatation.description)
            && token.hasSuffix(TokenSplitSign.quatation.description) ? true : false
    }
    
    private func isNumeric (_ token : String) -> Bool {
        guard let _: Int = Int(token) else {
            return false
        }
        return true
    }
    
    private func isBoolean (_ token : String) -> Bool {
        guard let _: Bool = Bool(token) else {
            return false
        }
        return true
    }
}
