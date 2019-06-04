//
//  Parser.swift
//  JSONParser
//
//  Created by hw on 24/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Parser {
    
    var tokenizer: Tokenizer = Tokenizer()
    
    func parse(_ tokenList: [String] ) -> JsonParsable {
        var result : JsonParsable = ""
        if tokenList[0] == TokenSplitSign.curlyBracketStart.description && tokenList[tokenList.count-1] ==
            TokenSplitSign.curlyBracketEnd.description {
            result = makeJsonObject(tokenList)
            return result
        }
        if tokenList[0] == TokenSplitSign.squareBracketStart.description && tokenList[tokenList.count-1] == TokenSplitSign.squareBracketEnd.description {
            result = makeJsonArray(tokenList)
        }
        return result
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
            let value = confirmJsonArrayValueType(tokenList: tokenList, index: &index)
            jsonArray.append(value)
            continue
        }
        return jsonArray
    }
    
    private func confirmJsonArrayValueType(tokenList: [String], index: inout Int) -> JsonParsable {
        let intCheck = isIntegerValue(value: tokenList[index])
        let booleanCheck = isBooleanValue(value: tokenList[index])
        let stringCheck = isStringValue(value: tokenList[index])
        
        if intCheck.isInteger {
            return intCheck.value
        }
        if booleanCheck.isBoolean {
            return booleanCheck.value
        }
        if isSquareBracketStart(tokenList[index]){
            let recursiveJsonArrayElement = saveJsonArrayElementInJsonArray(tokenList: tokenList, index: &index)
            return recursiveJsonArrayElement
        }
        if isCurlyBracketStart(tokenList[index]){
            let recursiveJsonObjectElement = saveJsonObjectElementInJsonArray(tokenList: tokenList, index: &index)
            return recursiveJsonObjectElement
        }
        return stringCheck.value
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
                let (key, value) = getKeyValueFromTokenizedJsonObject(tokenList: tokenList, index: &index)
                let jsonObjectElement = makeKeyValuePair(tokenList: tokenList, key: key, value: value, index: &index)
                jsonObject.add(key: key, value: jsonObjectElement )
            }
        }
        return jsonObject
    }
    
    private func makeKeyValuePair (tokenList: [String], key : String, value : String, index: inout Int) -> JsonParsable{
        /// check value type
        let intCheck = isIntegerValue(value: value)
        let booleanCheck = isBooleanValue(value: value)
        let stringCheck = isStringValue(value: value)

        if intCheck.isInteger {
            return intCheck.value
        }
        if booleanCheck.isBoolean {
            return booleanCheck.value
        }
        if isCurlyBracketStart(tokenList[index]){
            let recursiveJsonObjectElement = saveJsonObjectElementInJsonObject(tokenList: tokenList, index: &index)
            return recursiveJsonObjectElement
        }
        if isSquareBracketStart(tokenList[index]){                  /// [
            let recursiveJsonArrayElement = saveJsonArrayElementInJsonObject(tokenList: tokenList, index: &index)
            return recursiveJsonArrayElement
        }
        return stringCheck.value
    }
    
    private func saveJsonObjectElementInJsonObject(tokenList : [String], index: inout Int) -> JsonParsable  {
        var (stackForObject, innerIndex) = buildStackForNestedElement(tokenList: tokenList, index: index, start : isCurlyBracketStart, end : isCurlyBracketEnd)
        let recursiveJsonObjectElement = buildRecursivlyFromStackToJsonElement(stackForObject: &stackForObject, recursiveFunction: makeJsonObject)
        index = innerIndex
        return recursiveJsonObjectElement
    }
    
    private func saveJsonArrayElementInJsonObject(tokenList : [String], index: inout Int) -> JsonParsable{
        var (stackForArray, innerIndex) = buildStackForNestedElement(tokenList: tokenList, index: index, start: isSquareBracketStart, end: isSquareBracketEnd)
        let recursiveJsonArrayElement = buildRecursivlyFromStackToJsonElement(stackForObject: &stackForArray, recursiveFunction: makeJsonArray)
        index = innerIndex
        return recursiveJsonArrayElement
    }
    
    private func getKeyValueFromTokenizedJsonObject( tokenList: [String], index: inout Int) -> (key: String, value: String){
        let key = tokenList[index-1]
        index = index + 1
        let value = tokenList[index]    // n + 1, value 시작에 해당하는 값.
        return (key, value)
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
        var (stackForArray, innerIndex) = buildStackForNestedElement(tokenList: tokenList, index: index, start : isSquareBracketStart, end : isSquareBracketEnd)
        let recursiveJsonArrayElement = buildRecursivlyFromStackToJsonElement(stackForObject: &stackForArray, recursiveFunction: makeJsonArray)
        index = innerIndex
        return recursiveJsonArrayElement
    }
    
    private func saveJsonObjectElementInJsonArray(tokenList : [String], index: inout Int) -> JsonParsable {
        var (stackForArray, innerIndex) = buildStackForNestedElement(tokenList: tokenList, index: index, start : isCurlyBracketStart, end : isCurlyBracketEnd)
        let recursiveJsonObjectElement = buildRecursivlyFromStackToJsonElement(stackForObject: &stackForArray, recursiveFunction: makeJsonObject)
        index = innerIndex
        return recursiveJsonObjectElement
    }
    
    private func isIntegerValue(value: String) -> (isInteger : Bool , value: Int){
        if isNumeric(value) {
            guard let intValue = Int(value) else {
                return (false, -1)
            }
            return (true,intValue)
        }
        return (false, -1)
    }
    
    private func isBooleanValue(value: String) -> (isBoolean : Bool , value: Bool) {
        if isBoolean(value) {
            guard let boolValue = Bool(value) else {
                return (false, false)
            }
            return (true, boolValue)
        }
        return (false, false)
    }
    
    private func isStringValue(value: String) -> (isString : Bool , value: String) {
        if isString(value){
            return (true, value)
        }
        return (false, "")
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
    
    private func isSquareBracketStart(_ input: String ) -> Bool {
        return input.count == 1 && input == TokenSplitSign.squareBracketStart.description ? true : false
    }
    
    private func isSquareBracketEnd(_ input: String ) -> Bool {
        return input.count == 1 && input == TokenSplitSign.squareBracketEnd.description ? true : false
    }
    
    private func isCurlyBracketStart(_ input: String) -> Bool {
        return input.count == 1 && input == TokenSplitSign.curlyBracketStart.description ? true : false
    }
    
    private func isCurlyBracketEnd(_ input: String) -> Bool {
        return input.count == 1 && input == TokenSplitSign.curlyBracketEnd.description ? true : false
    }
}
