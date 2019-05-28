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
        var stackForArray : Stack<String> = Stack<String>()
        var stackForObject : Stack<String> = Stack<String>()
        var index = 0
        var innerIndex = index
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
                let key = tokenList[index-1]
                index = index + 1                   // n + 1, value 시작에 해당하는 값.
                let value = tokenList[index]

                /// check value type
                if isNumeric(value) {
                    guard let intValue = Int(tokenList[index]) else {
                        continue
                    }
                    jsonObject.add(key: key, value: intValue)
                    continue
                }
                if isBoolean(value) {
                    guard let boolValue = Bool(tokenList[index]) else {
                        continue
                    }
                    jsonObject.add(key: key, value: boolValue)
                    continue
                }
                if isString(value){
                    jsonObject.add(key: key, value: value)
                    continue
                }
                if isCurlyBracketStart(tokenList[index]){
                    stackForObject.push(tokenList[index])
                    innerIndex = index + 1
                    var curlyBracketCnt = 1
                    while (curlyBracketCnt != 0 ){
                        if isCurlyBracketStart(tokenList[innerIndex]){
                            curlyBracketCnt += 1
                        }else if isCurlyBracketEnd(tokenList[innerIndex]) {
                            curlyBracketCnt -= 1
                        }
                        stackForObject.push(tokenList[innerIndex])
                        innerIndex += 1
                    }
                    let allStackElement = makeStringFromStack(&stackForObject)
                    //recursive logic
                    let jsonObjectElement = tokenizer.tokenize(allStackElement)
                    let recursiveJsonObjectElement = makeJsonObject(jsonObjectElement)
                    /// add recursive Element to jsonArray
                    jsonObject.add(key: key, value: recursiveJsonObjectElement )
                    index = innerIndex
                    continue
                }
                if isSquareBracketStart(tokenList[index]){                  /// [
                    stackForArray.push(tokenList[index])
                    innerIndex = index + 1
                    var squareBracketCnt : Int = 1
                    while (squareBracketCnt != 0 ){
                        if isSquareBracketStart(tokenList[innerIndex]){
                            squareBracketCnt += 1
                        }else if isSquareBracketEnd(tokenList[innerIndex]) {
                            squareBracketCnt -= 1
                        }
                        stackForArray.push(tokenList[innerIndex])
                        innerIndex += 1
                    }
                    let allStackElement = makeStringFromStack(&stackForArray)
                    
                    //recursive logic
                    let jsonArrayElement = tokenizer.tokenize(allStackElement)
                    let recursiveJsonArrayElement = makeJsonArray(jsonArrayElement)
                    /// add recursive Element to jsonArray
                    jsonObject.add(key: key, value: recursiveJsonArrayElement )
                    index = innerIndex
                    continue
                }
            }
        }
        return jsonObject
    }
    
    
    private func makeJsonArray(_ tokenList: [String] ) -> JsonParsable {
        var jsonArray: JsonArray = JsonArray()
        var stack : Stack<String> = Stack<String>()
        var index = 0
        var innerIndex = index
    
        while index < tokenList.count {
            index += 1
            if index == tokenList.count {
                break
            }
            
            if isNumeric(tokenList[index]) {
                guard let intValue = Int(tokenList[index]) else {
                    continue
                }
                jsonArray.add(value: intValue)
                continue
            }
            if isBoolean(tokenList[index]) {
                guard let boolValue = Bool(tokenList[index]) else {
                    continue
                }
                jsonArray.add(value: boolValue)
                continue
            }
            if isString(tokenList[index]){
                jsonArray.add(value: tokenList[index])
                continue
            }
            
            if isSquareBracketStart(tokenList[index]){                  /// [
                stack.push(tokenList[index])
                innerIndex = index + 1
                var squareBracketCnt : Int = 1
                while (squareBracketCnt != 0 ){
                    if isSquareBracketStart(tokenList[innerIndex]){
                        squareBracketCnt += 1
                    }else if isSquareBracketEnd(tokenList[innerIndex]) {
                        squareBracketCnt -= 1
                    }
                    stack.push(tokenList[innerIndex])
                    innerIndex += 1
                }
                let allStackElement = makeStringFromStack(&stack)
                
                //recursive logic
                let jsonArrayElement = tokenizer.tokenize(allStackElement)
                let recursiveJsonArrayElement = makeJsonArray(jsonArrayElement)
                
                /// add recursive Element to jsonArray
                jsonArray.add(value: recursiveJsonArrayElement )
                index = innerIndex
                continue
            }
            
            if isCurlyBracketStart(tokenList[index]){
                var stackForObject : Stack<String> = Stack<String>()
                stackForObject.push(tokenList[index])
                innerIndex = index + 1
                var curlyBracketCnt = 1
                while (curlyBracketCnt != 0 ){
                    if isCurlyBracketStart(tokenList[innerIndex]){
                        curlyBracketCnt += 1
                    }else if isCurlyBracketEnd(tokenList[innerIndex]) {
                        curlyBracketCnt -= 1
                    }
                    stackForObject.push(tokenList[innerIndex])
                    innerIndex += 1
                }
                let allStackElement = makeStringFromStack(&stackForObject)
                //recursive logic
                let jsonObjectElement = tokenizer.tokenize(allStackElement)
                let recursiveJsonObjectElement = makeJsonArray(jsonObjectElement)
                /// add recursive Element to jsonArray
                jsonArray.add(value: recursiveJsonObjectElement )
                index = innerIndex
                continue
            }
        }
        return jsonArray
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
        return token.hasPrefix(TokenSplitStandard.quatation.description)
            && token.hasSuffix(TokenSplitStandard.quatation.description) ? true : false
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
