//
//  JSONTest.swift
//  JSONTest
//
//  Created by Yoda Codd on 2018. 5. 24..
//  Copyright © 2018년 JK. All rights reserved.
//

import XCTest

class JSONTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_JSONParser(){
//        let str = [" { \"name\" : \"KIM JUNG\", \"level\" : 5, \"married\" : true }"," 4"," false"," \"sd, true, {\"dsf\" : 4} f\" "]
        let str = [ "[", "{ \"name\" : \"KIM JUNG\", \"level\" : 5, \"married\" : true }"]
        let js = JSONParser()
        let flag = js.transform(letters: str)
        XCTAssert(flag != nil)
    }
    
    func testcheckWrappedBy() {
        let a = "{ \"name\" : \"KIM JUNG\", \"level\" : 5, \"married\" : true }"
        let regexedLetter = GrammarChecker.extractRegexed(regexTry: GrammarChecker.regexObject, originLetter: a)
//        let b = GrammarChecker.checkObjectType(letter: a)
        XCTAssert(a==regexedLetter!.first)
    }
    
    func testMainObject() {
        let input = "{ \"name\" : \"KIM JUNG\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
        
        // 입력값을 분류해주는 구조체 선언
        let classifier = Classifier()
        // 입력값을 JSON 스타일로 나눔
        guard let separatedLetters = classifier.surveyForJSON(letters: input) else {
            XCTAssert(false)
            return ()
        }
        // JSON 구조체 선언
        var json = JSONParser()
        // JSON Data 생성
        guard var dataOfJSON = json.make(letters: separatedLetters) else {
            XCTAssert(false)
            return ()
        }
        
        // 출력 구조체 선언
        var outputView = OutputView()
        outputView.printJSON(json: dataOfJSON)
        
        if dataOfJSON.jsonInformation.countOfObject == 0 && dataOfJSON.jsonInformation.countOfArray == 1  && dataOfJSON.type == "객체" && dataOfJSON.jsonInformation.countOfBool == 0 && dataOfJSON.jsonInformation.countOfInt == 1 && dataOfJSON.jsonInformation.countOfString == 1 {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testMainArray() {
        let input = "[ { \"name\" : \"master's course\", \"opened\" : true }, [ \"java\", \"javascript\", \"swift\" ], 3, true ]"
        
        // 입력값을 분류해주는 구조체 선언
        let classifier = Classifier()
        // 입력값을 JSON 스타일로 나눔
        guard let separatedLetters = classifier.surveyForJSON(letters: input) else {
            XCTAssert(false)
            return ()
        }
        
        // JSON 구조체 선언
        var json = JSONParser()
        // JSON Data 생성
        guard let dataOfJSON = json.make(letters: separatedLetters) else {
            XCTAssert(false)
            return ()
        }
        
        // 출력 구조체 선언
        var outputView = OutputView()
        outputView.printJSON(json: dataOfJSON)
        
        if dataOfJSON.jsonInformation.countOfObject == 1 && dataOfJSON.jsonInformation.countOfArray == 1  && dataOfJSON.type == "배열" && dataOfJSON.jsonInformation.countOfBool == 1 && dataOfJSON.jsonInformation.countOfInt == 1 {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func test_Regex(){
//        let str = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        let str = "\"children\" : [\"hana\", \"hayul\", \"haun\"]"
//        let str = "[\"hana\", \"hayul\", \"haun\"]"
//        let str = "a"
        let regexed = GrammarChecker.extractRegexed(regexTry: GrammarChecker.regexObjectValue, originLetter: str)
        
//        let str = "true"
//        let regexed = gram.extractRegexed(regexTry: GrammarChecker.regexBool, originLetter: str)
        
//        let result = gram.checkObjectType(letter: str)
        XCTAssert(str == regexed!.first)
        
    }
    
    func test_wrapper(){
        let input = "[ { \"name\" : \"master's course\", \"opened\" : true }, [ \"java\", \"javascript\", \"swift\" ] ]"
        //        let input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
        
        XCTAssert( Checker.checkArrayForJSON(letter: input) )
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
