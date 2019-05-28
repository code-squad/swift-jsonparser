//
//  ParserUnitTest.swift
//  JSONParserUnitTest
//
//  Created by hw on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class ParserUnitTest: XCTestCase {
    var tokenizer: TestTokenizer = TestTokenizer()
    let testInputJsonObject = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true }, true, \"context\" ]"
    let testSimpleInput = "[ 10 , \"jk\", 4, \"314\", 99, \"cro ng\", false, [ \"json\", [ false, 10 ], \"Array\" ], \"[ SquareBr, acke, tTest ]\", {\"abc\" : 10, \"bool\" : true}, \"{, {. [, [, curly , , ] ] ] ] \" ]"
    let test = "[ \"json\", [ false, 10 ], \"Array\" ]"
    let testJsonObject = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true, \"{ : }\" : \":\", \"curly bracket\":{ \"key\" : \"value\", \"size\" : 10, \"content\" : [ 10, 20, 30, 40 ] } }"
    
    func testParseJsonObjectInJsonArray(){
        let tokenList1 = tokenizer.tokenize(testInputJsonObject)
        if tokenList1[0] == TokenSplitSign.squareBracketStart.description && tokenList1[tokenList1.count-1] == TokenSplitSign.squareBracketEnd.description {
            /// JsonArray
            let result = makeJsonArray(tokenList1)
            print(" ======= makeJsonArray ======= ")
            print(result.description)
        }
    }
    
    func testParseJsonArray() {
        let tokenList = tokenizer.tokenize(testSimpleInput)
        if tokenList[0] == TokenSplitSign.squareBracketStart.description && tokenList[tokenList.count-1] == TokenSplitSign.squareBracketEnd.description {
            
            /// JsonArray
            let result = makeJsonArray(tokenList)
            print(" ======= makeJsonArray ======= ")
            print(result.description)
            
            //check data type
            XCTAssert(result is JsonArray, "parse array failure")
            guard let jsonArray = result as? JsonArray else {
                return
            }
            
            //check size
            XCTAssert( jsonArray.arrayList.count == 11, "parse nested element in array failure" )
        
            //check nested JsonArray element
            XCTAssert(jsonArray.arrayList[7] is JsonArray, "fail to parse nested JsonArray element - \(jsonArray.arrayList[7]) is JsonArray ")
            XCTAssert(jsonArray.arrayList[8] is String, "fail to parse nested JsonArray element - \(jsonArray.arrayList[8]) is String ")
            
            //check doubly nested JsonArray element
            guard let doublyNestedArray = jsonArray.arrayList[7] as? JsonArray else {
                return
            }
            XCTAssert(doublyNestedArray.arrayList[1]  is JsonArray, "fail to parse doublyNested JsonArray element - \(doublyNestedArray.arrayList[1] ) is JsonArray ")
        }
    }
    
    func testParseJsonObject() throws {
        let tokenList2 = tokenizer.tokenize(testJsonObject)
        if tokenList2[0] == TokenSplitSign.curlyBracketStart.description && tokenList2[tokenList2.count-1] ==
            TokenSplitSign.curlyBracketEnd.description {
            let result = makeJsonObject(tokenList2)
            print(" ======= makeJsonObject ======= ")
            print(result.description)
            //check data type
            XCTAssert(result is JsonObject, "parse object failure")
            
            //check size
            guard let jsonObject = result as? JsonObject else {
                return
            }
            XCTAssert( jsonObject.keyValueSet.count == 6, "parse nested element in array failure" )
            
            //check nested element
            do {
                let aliasValue = try jsonObject.searchValue(key: "alias").description
                XCTAssert ( aliasValue == "JK" , "fail to parse & find jsonObject element - \(aliasValue) " )
            } catch let errorType as ErrorCode{
                print (errorType.description)
            }
            
            //check nested element
            do {
                let curlyBracket = try jsonObject.searchValue(key: "curly bracket")
                XCTAssert ( curlyBracket is JsonObject , "fail to parse nested jsonObject element in jsonObject - \(curlyBracket) " )
                guard let curlyBracketObject = curlyBracket as? JsonObject else {
                   return
                }
                let contentValue = try curlyBracketObject.searchValue(key: "content")
                XCTAssert ( contentValue is JsonArray , "fail to parse nested jsonArray element in jsonObject - \(contentValue) " )

                guard let jsonArrayInObject = contentValue as? JsonArray else {
                    return
                }
                XCTAssert ( jsonArrayInObject.arrayList.count == 4 , "fail to parse nested jsonArray element in jsonObject - \(contentValue) " )
                
            } catch let errorType as ErrorCode{
                print (errorType.description)
            }
        }
    }
    
    private func makeJsonObject(_ tokenList: [String] ) -> JsonParsable {
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
                /// check value type
                if  tryToAddIntegerElementInJsonObject(value: value, key: key, jsonObject: &jsonObject) ||
                    tryToAddBooleanElementInJsonObject(value: value, key: key, jsonObject: &jsonObject) ||
                    tryToAddStringElementInJsonObject(value: value, key: key, jsonObject: &jsonObject) {
                    continue
                }
                if isCurlyBracketStart(tokenList[index]){
                    saveJsonObjectElementInJsonObject(tokenList: tokenList, index: &index, key: key, jsonObject: &jsonObject)
                    continue
                }
                if isSquareBracketStart(tokenList[index]){                  /// [
                    saveJsonArrayElementInJsonObject(tokenList: tokenList, index: &index, key: key, jsonObject: &jsonObject)
                    continue
                }
            }
        }
        return jsonObject
    }
    
    private func saveJsonObjectElementInJsonObject(tokenList : [String], index: inout Int, key: String, jsonObject: inout JsonObject)  {
        var (stackForObject, innerIndex) = buildStackForNestedElement(tokenList: tokenList, index: index, start : isCurlyBracketStart, end : isCurlyBracketEnd)
        let recursiveJsonObjectElement = buildRecursivlyFromStackToJsonElement(stackForObject: &stackForObject, recursiveFunction: makeJsonObject)
        jsonObject.add(key: key, value: recursiveJsonObjectElement )
        index = innerIndex
    }
    
    private func saveJsonArrayElementInJsonObject(tokenList : [String], index: inout Int, key: String,  jsonObject: inout JsonObject)  {
        var (stackForArray, innerIndex) = buildStackForNestedElement(tokenList: tokenList, index: index, start: isSquareBracketStart, end: isSquareBracketEnd)
        let recursiveJsonArrayElement = buildRecursivlyFromStackToJsonElement(stackForObject: &stackForArray, recursiveFunction: makeJsonArray)
        jsonObject.add(key: key, value: recursiveJsonArrayElement )
        index = innerIndex
    }
    
    private func getKeyValueFromTokenizedJsonObject( tokenList: [String], index: inout Int ) -> (key: String, value: String){
        let key = tokenList[index-1]
        index = index + 1                   // n + 1, value 시작에 해당하는 값.
        let value = tokenList[index]
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
    
    
    private func makeJsonArray(_ tokenList: [String] ) -> JsonParsable {
        var jsonArray: JsonArray = JsonArray()
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
            if isSquareBracketStart(tokenList[index]){                  /// [
                saveJsonArrayElementInJsonArray(tokenList: tokenList, index: &index, jsonArray: &jsonArray)
                continue
            }
            if isCurlyBracketStart(tokenList[index]){
                saveJsonObjectElementInJsonArray(tokenList: tokenList, index: &index, jsonArray: &jsonArray)
                continue
            }
        }
        return jsonArray
    }
    
    private func saveJsonArrayElementInJsonArray(tokenList : [String], index: inout Int, jsonArray: inout JsonArray) {
        var (stackForArray, innerIndex) = buildStackForNestedElement(tokenList: tokenList, index: index, start : isSquareBracketStart, end : isSquareBracketEnd)
        let recursiveJsonArrayElement = buildRecursivlyFromStackToJsonElement(stackForObject: &stackForArray, recursiveFunction: makeJsonArray)
        /// add recursive Element to jsonArray
        jsonArray.add(value: recursiveJsonArrayElement )
        index = innerIndex
    }
    
    private func saveJsonObjectElementInJsonArray(tokenList : [String], index: inout Int, jsonArray: inout JsonArray) {
        var (stackForArray, innerIndex) = buildStackForNestedElement(tokenList: tokenList, index: index, start : isCurlyBracketStart, end : isCurlyBracketEnd)
        let recursiveJsonObjectElement = buildRecursivlyFromStackToJsonElement(stackForObject: &stackForArray, recursiveFunction: makeJsonObject)
        /// add recursive Element to jsonArray
        jsonArray.add(value: recursiveJsonObjectElement )
        index = innerIndex
    }
    
    private func tryToAddIntegerElementInJsonObject(value: String, key: String, jsonObject: inout JsonObject) -> Bool {
        if isNumeric(value) {
            guard let intValue = Int(value) else {
                return false
            }
            jsonObject.add(key: key, value: intValue)
            return true
        }
        return false
    }
    
    private func tryToAddBooleanElementInJsonObject(value: String, key: String, jsonObject: inout JsonObject) -> Bool {
        if isBoolean(value) {
            guard let boolValue = Bool(value) else {
                return false
            }
            jsonObject.add(key: key, value: boolValue)
            return true
        }
        return false
    }
    
    private func tryToAddStringElementInJsonObject(value: String, key: String, jsonObject: inout JsonObject) -> Bool {
        if isString(value){
            jsonObject.add(key: key, value: value)
            return true
        }
        return false
    }
    
    private func tryToAddIntegerElementInJsonArray(tokenElement: String, jsonArray: inout JsonArray) -> Bool {
        if isNumeric(tokenElement) {
            guard let intValue = Int(tokenElement) else {
                return false
            }
            jsonArray.add(value: intValue)
            return true
        }
        return false
    }
    private func tryToAddBooleanElementInJsonArray(tokenElement: String, jsonArray: inout JsonArray) -> Bool {
        if isBoolean(tokenElement) {
            guard let boolValue = Bool(tokenElement) else {
                return false
            }
            jsonArray.add(value: boolValue)
            return true
        }
        return false
    }
    private func tryToAddStringElementInJsonArray(tokenElement: String, jsonArray: inout JsonArray) -> Bool {
        if isString(tokenElement){
            jsonArray.add(value: tokenElement)
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
