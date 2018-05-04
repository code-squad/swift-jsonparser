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
    
    let objectExpectNumber: String = "{\"key\":123}"
    let objectExpectString: String = "{\"key\":\"string\"}"
    let objectExpectBool: String = "{\"key\":false}"
    
    let arrayExpectNumber: String = "[1,2,3,4,5]"
    let arrayExpectString: String = "[\"string\",\"string\",\"string\",\"string\",\"string\"]"
    let arrayExpectBool: String = "[false,true,false,true]"
    
    let arrayExpectAnyObject: String = "[{\"key_1\":\"value\"},{\"key_2\":123},{\"key_3\":false}]"
    
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
        XCTAssertFalse(expectQue.isEmpty())
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
        XCTAssertTrue(expectQue.isEmpty())
    }
    
    // Queue : front후 값이 나오는지 체크
    func test_QueueFrontEqual() {
        let expectQue = Queue<String>()
        expectQue.enqueue(inputValue)
        XCTAssertEqual(inputValue, expectQue.front())
    }
    
    // Queue : front 후 값이 있는지 체크
    func test_QueueForntEmpty() {
        let expectQue = Queue<String>()
        expectQue.enqueue(inputValue)
        let _ = expectQue.front()
        XCTAssertFalse(expectQue.isEmpty())
    }
    
    // Queue : enqueue후 큐에 값이 들어 갔는지 체크
    func test_QueueEnqueueValue() {
        let expectQue = Queue<String>()
        expectQue.enqueue(inputValue)
        XCTAssertFalse(expectQue.isEmpty())
    }
    
    // MAKR : Stack
    
    // Stack : 값이 push되는지 체크
    func test_StackPush() {
        let expectStack = Stack<String>()
        expectStack.push(inputValue)
        XCTAssertFalse(expectStack.isEmpty())
    }
    
    // Stack : empty 체크 (값이 없을때)
    func test_StackEmptyValueTrue() {
        let expectStack = Stack<String>()
        XCTAssertTrue(expectStack.isEmpty())
    }
    
    // Stack : empty 체크 (값이 존재 할때)
    func test_StackEmptyValueFalse() {
        let expectStack = Stack<String>()
        expectStack.push(inputValue)
        XCTAssertFalse(expectStack.isEmpty())
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
        XCTAssertFalse(expectStack.isEmpty())
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
    
    // Parser : objectArray 타입 확인
    func test_숫자오브젝트() throws  {
        let tokens = try Lexer(objectExpectNumber).getToken()
        let expectOjbect = try Parser(tokens).parse()
        let jsonobject = expectOjbect as? JSONObjectArray
        XCTAssertNotNil(jsonobject)
    }
    
    // parser : objectArray 타입 확인 value string
    func test_문자오브젝트() throws {
        let tokens = try Lexer(objectExpectString).getToken()
        let expectOjbect = try Parser(tokens).parse()
        let jsonobject = expectOjbect as? JSONObjectArray
        XCTAssertNotNil(jsonobject)
    }
    
    // parser : ojbectArray 타입 확인 value boolean
    func test_부울오브젝트() throws {
        let tokens = try Lexer(objectExpectBool).getToken()
        let expectOjbect = try Parser(tokens).parse()
        let jsonobject = expectOjbect as? JSONObjectArray
        XCTAssertNotNil(jsonobject)
    }
    
    // Parser : JsonArray value : number
    func test_숫자배열() throws {
        let tokens = try Lexer(arrayExpectNumber).getToken()
        let expectArray = try Parser(tokens).parse()
        let jsonarray = expectArray as? JSONArray
        XCTAssertNotNil(jsonarray)
    }
    
    // Parser : JsonArray value : string
    func test_문자배열() throws {
        let tokens = try Lexer(arrayExpectString).getToken()
        let expectArray = try Parser(tokens).parse()
        let array = expectArray as? JSONArray
        XCTAssertNotNil(array)
    }
    
    // Parser : JsonArray value : boolean
    func test_부울배열() throws {
        let tokens = try Lexer(arrayExpectBool).getToken()
        let expectArray = try Parser(tokens).parse()
        let array = expectArray as? JSONArray
        XCTAssertNotNil(array)
    }
    
    // Parser : JsonArray value : Ojbect
    func test_오브젝트배열() throws {
        let tokens = try Lexer(arrayExpectAnyObject).getToken()
        let expectArray = try Parser(tokens).parse()
        let array = expectArray as? JSONArray
        XCTAssertNotNil(array)
    }
}
