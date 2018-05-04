//
//  JSONUnitTest.swift
//  JSONUnitTest
//
//  Created by rhino Q on 2018. 3. 29..
//  Copyright © 2018년 JK. All rights reserved.

// TODO:- step4 피드백 2
// 아직까지 단위 테스트 함수는 하나의 객체에서 하나의 기능만 테스트하도록 작성하세요.
// 따라서 token 데이터를 직접 만들어야 합니다.

import XCTest
@testable import JSONParser

extension Token:Equatable {
    static func == (lhs: Token, rhs: Token) -> Bool {
        switch (lhs, rhs) {
        case (.jsonArray(let tokensOfLhs), .jsonArray(let tokensOfRhs)):
            return checkTwoPairOfJsonArrayIsEqual(tokensOfLhs, tokensOfRhs)
        case (.jsonObject(let objectOfLhs), .jsonObject(let objectOfRhs)):
            return checkTwoPairOfJsonObjectIsEqual(objectOfLhs, objectOfRhs)
        case (.number(let valueOfLhs), .number(let valueOfRhs)):
            return valueOfLhs == valueOfRhs
        case (.string(let valueOfLhs), .string(let valueOfRhs)):
            return valueOfLhs == valueOfRhs
        case (.bool(let valueOfLhs), .bool(let valueOfRhs)):
            return valueOfLhs == valueOfRhs
        default:
            return false
        }
    }
}

extension Token {
    
    static func checkTwoPairOfJsonArrayIsEqual(_ tokensOfLhs:[Token], _ tokensOfRhs:[Token]) -> Bool {
        var result = true
        zip(tokensOfLhs, tokensOfRhs).forEach {
            if $0 != $1 {
                result = false
                return
            }
        }
        return result
    }
    
    static func checkTwoPairOfJsonObjectIsEqual(_ objectOfLhs:JSONObject, _ objectOfRhs:JSONObject) -> Bool {
        var result = true
        zip(objectOfLhs, objectOfRhs).forEach {
            if $0.key != $1.key { result = false; return; }
            if $0.value != $1.value { result = false; return; }
        }
        return result
    }
}



class JSONUnitTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testJSONLexerNumbersSuccessInLexer() {
        let input = "[ 10, 20, 30, 40, 50]"
        var lexer = JSONLexer(input: input)
        let tokens = try! lexer.lex()
        let myTokens = Token.jsonArray(tokens: [.number(value: 10.0), .number(value: 20.0), .number(value: 30.0), .number(value: 40.0), .number(value: 50.0)])
        
        XCTAssertTrue(tokens == myTokens)
    }
    
    func testJSONLexerNumbersSuccessInParser() {
        let myTokens = Token.jsonArray(tokens: [.number(value: 10.0), .number(value: 20.0), .number(value: 30.0), .number(value: 40.0), .number(value: 50.0)])

        var parser = JSONParser(myTokens)
        let jsonData = try! parser.parse()
        
        XCTAssertEqual(jsonData.numberCount, 5, "should be equal")
        XCTAssertEqual(jsonData.stringCount, 0, "should be equal")
        XCTAssertEqual(jsonData.boolCount, 0, "should be equal")
        XCTAssertEqual(jsonData.arrayCount, 0, "should be equal")
        XCTAssertEqual(jsonData.objectCount, 0, "should be equal")
        XCTAssertEqual(jsonData.paranet.count, 5, "should be equal")
        XCTAssertEqual(jsonData.paranet.name, "배열", "should be equal")
    }
    
    
    func testJSONLexerNumbersAndStringSuccessInLexer() {
        let input = "[ 10, \"20\", 30, 40, 50, \"sdf\" ]"
        var lexer = JSONLexer(input: input)
        let tokens = try! lexer.lex()
        let myTokens = Token.jsonArray(tokens: [.number(value: 10.0), .string(value: "\"20\""), .number(value: 30.0), .number(value: 40.0), .number(value: 50.0), .string(value: "\"sdf\"")])
        
        XCTAssertTrue(tokens == myTokens)
    }
    
    func testJSONLexerNumbersAndStringSuccessInParser() {
        let myTokens = Token.jsonArray(tokens: [.number(value: 10.0), .string(value: "\"20\""), .number(value: 30.0), .number(value: 40.0), .number(value: 50.0), .string(value: "\"sdf\"")])
        var parser = JSONParser(myTokens)
        let jsonData = try! parser.parse()
        
        XCTAssertEqual(jsonData.numberCount, 4, "should be equal")
        XCTAssertEqual(jsonData.stringCount, 2, "should be equal")
        XCTAssertEqual(jsonData.boolCount, 0, "should be equal")
        XCTAssertEqual(jsonData.arrayCount, 0, "should be equal")
        XCTAssertEqual(jsonData.objectCount, 0, "should be equal")
        XCTAssertEqual(jsonData.paranet.count, 6, "should be equal")
        XCTAssertEqual(jsonData.paranet.name, "배열", "should be equal")
    }

    func testJSONLexerNumbersAndStringsAndBoolsSuccessInLexer() {
        let input = "[ false, 10, \"2.0\", 30, 4.0, 50, \"sdf\"]"
        var lexer = JSONLexer(input: input)
        let tokens = try! lexer.lex()
        let myTokens = Token.jsonArray(tokens: [.bool(value: false), .number(value: 10), .string(value: "\"2.0\""), .number(value: 30.0), .number(value: 4.0), .number(value: 50.0), .string(value: "\"sdf\"")])
        XCTAssertTrue(tokens == myTokens)
    }
    
    func testJSONLexerNumbersAndStringsAndBoolsSuccessInParser() {
        let myTokens = Token.jsonArray(tokens: [.bool(value: false), .number(value: 10), .string(value: "\"2.0\""), .number(value: 30.0), .number(value: 4.0), .number(value: 50.0), .string(value: "\"sdf\"")])
        var parser = JSONParser(myTokens)
        let jsonData = try! parser.parse()
        
        XCTAssertEqual(jsonData.numberCount, 4, "should be equal")
        XCTAssertEqual(jsonData.stringCount, 2, "should be equal")
        XCTAssertEqual(jsonData.boolCount, 1, "should be equal")
        XCTAssertEqual(jsonData.arrayCount, 0, "should be equal")
        XCTAssertEqual(jsonData.objectCount, 0, "should be equal")
        XCTAssertEqual(jsonData.paranet.count, 7, "should be equal")
        XCTAssertEqual(jsonData.paranet.name, "배열", "should be equal")
    }
    
    func testJSONLexerObjectSuccessInLexer() {
        let input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        var lexer = JSONLexer(input: input)
        let tokens = try! lexer.lex()
        let myTokens = Token.jsonObject(["\"name\"":.string(value: "\"KIM JUNG\""), "\"alias\"":.string(value: "\"JK\""), "\"level\"":.number(value: 5), "\"married\"":.bool(value: true)])
        XCTAssertTrue(tokens == myTokens)
    }
    
    func testJSONLexerObjectSuccessInParser() {

        let myTokens = Token.jsonObject(["\"name\"":.string(value: "\"KIM JUNG\""), "\"alias\"":.string(value: "\"JK\""), "\"level\"":.number(value: 5), "\"married\"":.bool(value: true)])

        var parser = JSONParser(myTokens)
        let jsonData = try! parser.parse()
        
        XCTAssertEqual(jsonData.numberCount, 1, "should be equal")
        XCTAssertEqual(jsonData.stringCount, 2, "should be equal")
        XCTAssertEqual(jsonData.boolCount, 1, "should be equal")
        XCTAssertEqual(jsonData.arrayCount, 0, "should be equal")
        XCTAssertEqual(jsonData.objectCount, 0, "should be equal")
        XCTAssertEqual(jsonData.paranet.count, 4, "should be equal")
        XCTAssertEqual(jsonData.paranet.name, "객체", "should be equal")
    }

    func testJSONLexerObjectInArrayInLexer(){
        let input = "[{\"name\":\"KIM JUNG\", \"alias\":\"JK\", \"level\": 5, \"married\" : true }, { \"name\" : \"YOON JISU\",  \"alias\" : \"crong\", \"level\":4, \"married\":true}]"
        var lexer = JSONLexer(input: input)
        let tokens = try! lexer.lex()
        let jsonObjectOne = Token.jsonObject(["\"name\"":.string(value: "\"KIM JUNG\""), "\"alias\"":.string(value: "\"JK\""), "\"level\"":.number(value: 5), "\"married\"":.bool(value: true)])
        let jsonObjectTwo = Token.jsonObject(["\"name\"":.string(value: "\"YOON JISU\""), "\"alias\"":.string(value: "\"crong\""), "\"level\"":.number(value: 4), "\"married\"":.bool(value: true)])
        let myTokens = Token.jsonArray(tokens: [jsonObjectOne, jsonObjectTwo])
        XCTAssertTrue(tokens == myTokens)
    }
    
    func testJSONLexerObjectInArrayInParser(){
        let jsonObjectOne = Token.jsonObject(["\"name\"":.string(value: "\"KIM JUNG\""), "\"alias\"":.string(value: "\"JK\""), "\"level\"":.number(value: 5), "\"married\"":.bool(value: true)])
        let jsonObjectTwo = Token.jsonObject(["\"name\"":.string(value: "\"YOON JISU\""), "\"alias\"":.string(value: "\"crong\""), "\"level\"":.number(value: 4), "\"married\"":.bool(value: true)])
        let myTokens = Token.jsonArray(tokens: [jsonObjectOne, jsonObjectTwo])
        var parser = JSONParser(myTokens)
        let jsonData = try! parser.parse()
        
        XCTAssertEqual(jsonData.numberCount, 0, "should be equal")
        XCTAssertEqual(jsonData.stringCount, 0, "should be equal")
        XCTAssertEqual(jsonData.boolCount, 0, "should be equal")
        XCTAssertEqual(jsonData.arrayCount, 0, "should be equal")
        XCTAssertEqual(jsonData.objectCount, 2, "should be equal")
        XCTAssertEqual(jsonData.paranet.count, 2, "should be equal")
        XCTAssertEqual(jsonData.paranet.name, "배열", "should be equal")
        
    }

    func testJSONLexerArrayInObjectSuccessForStep4InLexer(){
        let input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
        var lexer = JSONLexer(input: input)
        let tokens = try! lexer.lex()
        
        let jsonArray = Token.jsonArray(tokens: [.string(value: "\"hana\""), .string(value: "\"hayul\""), .string(value: "\"haun\"")])
        let myTokens = Token.jsonObject(["\"name\"":.string(value: "\"KIM JUNG\""), "\"alias\"":.string(value: "\"JK\""), "\"level\"":.number(value: 5), "\"children\"":jsonArray])
        XCTAssertTrue(tokens == myTokens)
    }
    
    func testJSONLexerArrayInObjectSuccessForStep4InParser(){
        let jsonArray = Token.jsonArray(tokens: [.string(value: "\"hana\""), .string(value: "\"hayul\""), .string(value: "\"haun\"")])
        let myTokens = Token.jsonObject(["\"name\"":.string(value: "\"KIM JUNG\""), "\"alias\"":.string(value: "\"JK\""), "\"level\"":.number(value: 5), "\"children\"":jsonArray])
        var parser = JSONParser(myTokens)
        let jsonData = try! parser.parse()
        
        XCTAssertEqual(jsonData.numberCount, 1, "should be equal")
        XCTAssertEqual(jsonData.stringCount, 2, "should be equal")
        XCTAssertEqual(jsonData.boolCount, 0, "should be equal")
        XCTAssertEqual(jsonData.arrayCount, 1, "should be equal")
        XCTAssertEqual(jsonData.objectCount, 0, "should be equal")
        XCTAssertEqual(jsonData.paranet.count, 4, "should be equal")
        XCTAssertEqual(jsonData.paranet.name, "객체", "should be equal")
    }
 
    func testJSONLexerArrayAndObjectInArraySuccessForStep4InLexer(){
        let input = "[ { \"name\" : \"master's course\", \"opened\" : true }, [ \"java\", \"javascript\", \"swift\" ] ]"
        var lexer = JSONLexer(input: input)
        let tokens = try! lexer.lex()
        
        let jsonObjectOne = Token.jsonObject(["\"name\"":.string(value: "\"master's course\""), "\"opened\"":.bool(value: true)])
        let jsonArray = Token.jsonArray(tokens: [.string(value: "\"java\""), .string(value: "\"javascript\""), .string(value: "\"swift\"")])
        let myTokens = Token.jsonArray(tokens: [jsonObjectOne, jsonArray])
        
        XCTAssertTrue(tokens == myTokens)
        
    }
    
    func testJSONLexerArrayAndObjectInArraySuccessForStep4InParser(){
        let jsonObjectOne = Token.jsonObject(["\"name\"":.string(value: "\"master's course\""), "\"opened\"":.bool(value: true)])
        let jsonArray = Token.jsonArray(tokens: [.string(value: "\"java\""), .string(value: "\"javascript\""), .string(value: "\"swift\"")])
        let myTokens = Token.jsonArray(tokens: [jsonObjectOne, jsonArray])
        var parser = JSONParser(myTokens)
        let jsonData = try! parser.parse()
        
        XCTAssertEqual(jsonData.numberCount, 0, "should be equal")
        XCTAssertEqual(jsonData.stringCount, 0, "should be equal")
        XCTAssertEqual(jsonData.boolCount, 0, "should be equal")
        XCTAssertEqual(jsonData.arrayCount, 1, "should be equal")
        XCTAssertEqual(jsonData.objectCount, 1, "should be equal")
        XCTAssertEqual(jsonData.paranet.count, 2, "should be equal")
        XCTAssertEqual(jsonData.paranet.name, "배열", "should be equal")
    }
    

    
    func testJSONLexerInvalidFormatObjectInArrayException(){
        let input = "[{\"name\":\"KIm JUNG\", \"alias\":\"JK\", \"level\": 5, \"married\" : true }, { \"name\" : \"YOON JISU\",  \"alias\" : \"crong\", \"leve\", \"level\":4, \"married\":true]"
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatObjectException(){
        let input = "{ false, 10, \"2.0\", 30, 4.0, 50, \"sdf\""
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatLexException(){
        let input = "sdf[ false, 10, \"2.0\", 30, 4.0, 50, \"sdf\""
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatBracketLexException(){
        let input = "[ false, 10, \"2.0\", 30, 4.0, 50, \"sdf\""
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatDoubleQuoteLexException(){
        let input = "[ false, 10, \"2.0, 30, 4.0, 50, \"sdf\""
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatBoolLexException(){
        let input = "[ falAse, 10, \"2.0, 30, 4.0, 50, \"sdf\""
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatNumberLexException(){
        let input = "[ false, 10, \"2.0\", 3-0, 4.0, 50, \"sdf\"]"
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatDoubleLexException(){
        let input = "[ false, 10, \"2.0\", 30, 4.-0, 50, \"sdf\"]"
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatObjectInArrayExceptionForStep3(){
        let input = "[\"name\" : \"KIM JUNG\"]"
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
//    func testJSONLexerInvalidFormatArrayInObjectExceptionForStep3(){
//        let input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
//        var lexer = JSONLexer(input: input)
//        XCTAssertThrowsError(try lexer.lex()) { error in
//            print(error)
//        }
//    }
}
