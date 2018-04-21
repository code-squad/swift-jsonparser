//
//  JSONParserUnitTest.swift
//  JSONParserUnitTest
//
//  Created by Jung seoung Yeo on 2018. 4. 19..
//  Copyright © 2018년 JK. All rights reserved.
//

import XCTest

class JSONParserUnitTest: XCTestCase {
    
    let jsonFormat: String = "[ 10, 21, 4, 314, 99, 0, 72 ]"
    let jsonFormatRemoveSpace: String = "[10,21,4,314,99,0,72]"
    let inputValue = "value"
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK : String+
    
    // String+ : 공백 제거
    func test_removeSpacePass() {
        let expectValue = jsonFormat.trim()
        XCTAssertEqual(jsonFormatRemoveSpace, expectValue)
    }
    
    // String+ : 공백이 제거가 안된 값이랑 비교
    func test_removeSplaceNoPass() {
        let expectValue = jsonFormat.trim()
        XCTAssertNotEqual(jsonFormat, expectValue)
    }
    
    // String+ : 문자열 정규식 체크
    func test_RegexStringPass() {
        let expectStringValue = "\"s\""
        XCTAssertNoThrow(try expectStringValue.pattenMatching(RegexPatten.StringPatten.rawValue))
    }
    
    // String+ : 문자열 정규식 체크
    func test_RegexStringNoPass() {
        let unExpectStringValue = "12"
        XCTAssertThrowsError(try unExpectStringValue.pattenMatching(RegexPatten.StringPatten.rawValue))
    }
    
    // String+ : 숫자열 정규식 체크
    func test_RegexNumberPass() {
        let expectNumberValue = "123"
        XCTAssertNoThrow(try expectNumberValue.pattenMatching(RegexPatten.NumberPatten.rawValue))
    }
    
    // String+ : 숫자열 정규식 체크
    func test_RegexNumberNoPass() {
        let unExpectNumberValue = "string"
        XCTAssertThrowsError(try unExpectNumberValue.pattenMatching(RegexPatten.NumberPatten.rawValue))
    }
    
    // String+ : 부울 정규식 체크
    func test_RegexBooleanPass() {
        let expectBooleanValue = "false"
        XCTAssertNoThrow(try expectBooleanValue.pattenMatching(RegexPatten.BooleanPaten.rawValue))
    }
    
    // String+ : 부울 정규식 체크
    func test_RegexBooleanNoPass() {
        let unExpectBooleanValue = "string"
        XCTAssertThrowsError(try unExpectBooleanValue.pattenMatching(RegexPatten.BooleanPaten.rawValue))
    }
    
    // MARK : Queue
    
    // Queue : 값이 존재 할때 빈 값 체크
    func test_QueueEnqueue() {
        let expectQue = Queue<String>()
        expectQue.enqueue("value")
        XCTAssertFalse(expectQue.empty())
    }
    
    // Queue : dequeue로 값이 나오는지 체크
    func test_QueueDequeueValue() {
        let expectQue = Queue<String>()
        expectQue.enqueue(inputValue)
        XCTAssertEqual( inputValue, expectQue.dequeue())
    }
    
    // Queue : dequeue 후 값이 존재하는지 체크
    func test_QueueDequeueEmpty() {
        let expectQue = Queue<String>()
        expectQue.enqueue(inputValue)
        let _ = expectQue.dequeue()
        XCTAssertTrue(expectQue.empty())
    }
    
    // Queue : front후 값이 나오는지 체크
    func test_QueueFrontEqual() {
        let expectQue = Queue<String>()
        expectQue.enqueue(inputValue)
        XCTAssertEqual(inputValue, expectQue.font())
    }
    
    // Queue : front 후 값이 있는지 체크
    func test_QueueForntEmpty() {
        let expectQue = Queue<String>()
        expectQue.enqueue(inputValue)
        let _ = expectQue.font()
        XCTAssertFalse(expectQue.empty())
    }
    
    // Queue : enqueue후 큐에 값이 들어 갔는지 체크
    func test_QueueEnqueueValue() {
        let expectQue = Queue<String>()
        expectQue.enqueue(inputValue)
        XCTAssertFalse(expectQue.empty())
    }
    
    // MAKR : Stack
    
    // Stack : 값이 push되는지 체크
    func test_StackPush() {
        let expectStack = Stack<String>()
        expectStack.push(inputValue)
        XCTAssertFalse(expectStack.empty())
    }
    
    // Stack : empty 체크 (값이 없을때)
    func test_StackEmptyValueTrue() {
        let expectStack = Stack<String>()
        XCTAssertTrue(expectStack.empty())
    }
    
    // Stack : empty 체크 (값이 존재 할때)
    func test_StackEmptyValueFalse() {
        let expectStack = Stack<String>()
        expectStack.push(inputValue)
        XCTAssertFalse(expectStack.empty())
    }
    
    // Stack : 값이 잘 나오는지 체크
    func test_StackPop() {
        let expectStack = Stack<String>()
        expectStack.push(inputValue)
        let pop = expectStack.pop()
        XCTAssertEqual(pop, inputValue)
    }
    
    // Stack : peek후 값이 잘 나오는지 체크
    func test_StackPeekValue() {
        let expectStack = Stack<String>()
        expectStack.push(inputValue)
        let peek = expectStack.peek()
        XCTAssertEqual(peek, inputValue)
    }
    
    // Stack : 값이 없을 때 빈값 나오는지 체크
    func test_StackPeekNil() {
        let expectStack = Stack<String>()
        let peek = expectStack.peek()
        XCTAssertNil(peek)
    }
    
    // Stack : peek 후 값이 존재하는지 체크
    func test_StackPeekAfterNilCheck() {
        let expectStack = Stack<String>()
        expectStack.push(inputValue)
        let _ = expectStack.peek()
        XCTAssertFalse(expectStack.empty())
    }
    
    //MARK : Lexer
    
    // Lexer : Token 생성
    func test_LexerGetTokenPass() {
        let lexer = Lexer(jsonFormat)
        XCTAssertNoThrow(try lexer.getToken())
    }
    
    // Lexer : Token 생성 실패
    func test_lexerGetTokenNoPass() {
        let unExpectValue = "qweerttyu"
        let lexer = Lexer(unExpectValue)
        XCTAssertThrowsError(try lexer.getToken())
    }
    
    // MARK : Parser
    
    //  Parser : 객체 생성
    func test_ParserInstanceCreate() throws {
        let expectLexer = Lexer(jsonFormat)
        let expectToken = try expectLexer.getToken()
        let expectParser = Paser(expectToken)
        XCTAssertNotNil(expectParser)
    }
    
    // Paser : 제대로 된 parse
    func test_ParserPass() throws {
        let expectLexer = Lexer(jsonFormat)
        let expectToken = try expectLexer.getToken()
        let expectParser = Paser(expectToken)
        XCTAssertNoThrow(try expectParser.parse())
    }
    
    // Parser : 배열 안 형식이 아닐떄
    func test_ParserNoArrayFormat() throws {
        let unJsonFormat = "[ 10, 21, 4, 314, 99, 0, 72 "
        let expectLexer = Lexer(unJsonFormat)
        let expectToken = try expectLexer.getToken()
        let expectParser = Paser(expectToken)
        XCTAssertThrowsError(try expectParser.parse())
    }

    // Parser : 숫자 데이타에 저장되는지 체크
    func test_ParserAfterSetNumberData() throws {
        let expectLexer = Lexer(jsonFormat)
        let expectToken = try expectLexer.getToken()
        let expectParser = Paser(expectToken)
        let jsonData = try expectParser.parse()
        XCTAssertEqual(7, jsonData.countOfNumber())
    }
    
    // Parser : 문자 데이터에 저장되는지 체크
    func test_ParserAfterSetStringData() throws {
        let jsonStringData = "[\"s\",\"string\"]"
        let expectLexer = Lexer(jsonStringData)
        let expectToken = try expectLexer.getToken()
        let expectParser = Paser(expectToken)
        let jsonData = try expectParser.parse()
        XCTAssertEqual(2, jsonData.countOfString())
    }
    
    // Parser : 부울 데이터에 저장되는지 체크
    func test_ParserAfterSetBooleanData() throws {
        let jsonBooleanData = "[false, true]"
        let expectLexer = Lexer(jsonBooleanData)
        let expectToken = try expectLexer.getToken()
        let expectParser = Paser(expectToken)
        let jsonData = try expectParser.parse()
        XCTAssertEqual(2, jsonData.countOfBoolean())
    }
    
    // Parser : 숫자, 문자, 부울 분리 되어 저장되는지 체크
    func test_ParserMutilSetData() throws {
        let jsonFormat = "[\"false\", false, 123]"
        let expectLexer = Lexer(jsonFormat)
        let expectToken = try expectLexer.getToken()
        let expectParser = Paser(expectToken)
        let jsonData = try expectParser.parse()
        
        XCTAssertEqual(1, jsonData.countOfString())
        XCTAssertEqual(1, jsonData.countOfNumber())
        XCTAssertEqual(1, jsonData.countOfBoolean())
    }
}
