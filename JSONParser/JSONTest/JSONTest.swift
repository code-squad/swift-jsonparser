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
//        print( flag)
        XCTAssert(flag != nil)
    }
    
    func testcheckWrappedBy() {
        let a = "{ \"name\" : \"KIM JUNG\", \"level\" : 5, \"married\" : true }"
        let regexedLetter = GrammarChecker.extractRegexed(regexTry: GrammarChecker.regexObject, originLetter: a)
        print(regexedLetter)
//        let b = GrammarChecker.checkObjectType(letter: a)
        XCTAssert(true)
    }
    
    func testMain() {
//        let input = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } ]"
        let input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        // 입력값을 분류해주는 구조체 선언
        let classifier = Classifier()
        // 입력값을 JSON 스타일로 나눔
        guard let separatedLetters = classifier.surveyForJSON(letters: input) else {
            print("잘못된 입력")
            return ()
        }
        print (separatedLetters)
        // JSON 구조체 선언
        let json = JSONParser()
        // JSON Data 생성
        guard let dataOfJSON = json.transform(letters: separatedLetters) else {
            print("지원하지 않는 형식을 포함하고 있습니다.")
            return ()
        }
        
        // 출력 구조체 선언
        let outputView = OutputView()
        outputView.printCountOfTypes(json: dataOfJSON)
    }
    
    func test_Regex(){
        let str = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        let regexed = GrammarChecker.extractRegexed(regexTry: GrammarChecker.regexObject, originLetter: str)
        
//        let str = "true"
//        let regexed = gram.extractRegexed(regexTry: GrammarChecker.regexBool, originLetter: str)
        
        print(regexed)
        
//        let result = gram.checkObjectType(letter: str)
//        XCTAssert(result)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
