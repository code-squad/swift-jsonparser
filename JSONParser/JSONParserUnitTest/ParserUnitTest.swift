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
    let testJsonObject = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true, \"{ : }\" : \"curly bracket : \", \"curly bracket\":{ \"key\" : \"value\", \"size\":10 } }"
    
    func testParse() {
       
        let tokenList = tokenizer.tokenize(testSimpleInput)
        let tokenList1 = tokenizer.tokenize(testInputJsonObject)
        let tokenList2 = tokenizer.tokenize(testJsonObject)

        for i in tokenList {
            print(i)
        }
        
        
        if tokenList[0] == TokenSplitSign.squareBracketStart.description && tokenList[tokenList.count-1] == TokenSplitSign.squareBracketEnd.description {
            /// JsonArray
            makeJsonArray(tokenList)
            
        }
        
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
                    let curVal = tokenList [innerIndex]
                    if isSquareBracketStart(tokenList[innerIndex]){
                        squareBracketCnt += 1
                    }else if isSquareBracketEnd(tokenList[innerIndex]) {
                        squareBracketCnt -= 1
                    }
                    stack.push(tokenList[innerIndex])
                    innerIndex += 1
                }
                let innerElement = makeStringFromStack(&stack)
                let innerArray = tokenizer.tokenize(innerElement)
                let innerResult = makeJsonArray(innerArray)
                jsonArray.add(value: innerResult )
                index = innerIndex
                continue
            }
            
            if isCurlyBracketStart(tokenList[index]) {
                var innerJsonObject : JsonObject = JsonObject()
                stack.push(tokenList[index])
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
       
        print("stack result : > \(result)")
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
