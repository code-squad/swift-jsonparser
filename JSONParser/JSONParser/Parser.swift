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
        }else if tokenList[0] == TokenSplitSign.squareBracketStart.description && tokenList[tokenList.count-1] == TokenSplitSign.squareBracketEnd.description {
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
            if  tryToAddIntegerElementInJsonArray(tokenElement: tokenList[index], jsonArray: &jsonArray) ||
                tryToAddBooleanElementInJsonArray(tokenElement: tokenList[index], jsonArray: &jsonArray) ||
                tryToAddStringElementInJsonArray(tokenElement:  tokenList[index], jsonArray: &jsonArray) {
                continue
            }
            if isSquareBracketStart(tokenList[index]){                  
                let recursiveJsonArrayElement = saveJsonArrayElementInJsonArray(tokenList: tokenList, index: &index)
                jsonArray.append(recursiveJsonArrayElement)
                continue
            }
            if isCurlyBracketStart(tokenList[index]){
                let recursiveJsonObjectElement = saveJsonObjectElementInJsonArray(tokenList: tokenList, index: &index)
                jsonArray.append(recursiveJsonObjectElement)
                continue
            }
        }
        return jsonArray
    }
    
    private func makeJsonObject(_ tokenList: [String]) -> JsonParsable {
        var jsonObject: JsonObject = JsonObject()
        var index = 0
        while index < tokenList.count {
            index += 1
            if index >= tokenList.count {
                break
            }
            if tokenList[index] == "," {
                continue
            }
            if tokenList[index] == ":" {
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
        let intCheck = tryToAddIntegerElementInJsonObject(value: value)
        let booleanCheck = tryToAddBooleanElementInJsonObject(value: value)
        let stringCheck = tryToAddStringElementInJsonObject(value: value)

        if  intCheck.isInteger {
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
    
    private func tryToAddIntegerElementInJsonObject(value: String) -> (isInteger : Bool , value: Int){
        if isNumeric(value) {
            guard let intValue = Int(value) else {
                return (false, -1)
            }
            return (true,intValue)
        }
        return (false, -1)
    }
    
    private func tryToAddBooleanElementInJsonObject(value: String) -> (isBoolean : Bool , value: Bool) {
        if isBoolean(value) {
            guard let boolValue = Bool(value) else {
                return (false, false)
            }
            return (true, boolValue)
        }
        return (false, false)
    }
    
    private func tryToAddStringElementInJsonObject(value: String) -> (isString : Bool , value: String) {
        if isString(value){
            return (true, value)
        }
        return (false, "")
    }
    
    private func tryToAddIntegerElementInJsonArray(tokenElement: String, jsonArray: inout [JsonParsable]) -> Bool {
        if isNumeric(tokenElement) {
            guard let intValue = Int(tokenElement) else {
                return false
            }
            jsonArray.append(intValue)
            return true
        }
        return false
    }
    
    private func tryToAddBooleanElementInJsonArray(tokenElement: String, jsonArray: inout [JsonParsable]) -> Bool {
        if isBoolean(tokenElement) {
            guard let boolValue = Bool(tokenElement) else {
                return false
            }
            jsonArray.append(boolValue)
            return true
        }
        return false
    }
    
    private func tryToAddStringElementInJsonArray(tokenElement: String, jsonArray: inout [JsonParsable]) -> Bool {
        if isString(tokenElement){
            jsonArray.append(tokenElement)
            return true
        }
        return false
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
