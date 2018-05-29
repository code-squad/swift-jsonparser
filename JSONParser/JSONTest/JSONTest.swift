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
    
    func testExample() {
        let checker = Checker()
//        let input = "[{ \"name\" : \"KIM JUNG\", \"level\" : 5, \"married\" : true }, 4, false, \"sd, true, {\"dsf\" : 4} f\"]"
        let input = "{ \"name\" : \"KIM JUNG\", \"level\" : 5, \"married\" : true }"
        let classifier = Classifier()
        
        let separated = classifier.surveyLettersByJSON(letters: input)!
        let json = JSON()
        let result = json.transformLetterToJSON(letters: separated)
        print (result?.countValues())
        XCTAssert(separated == separated )
    }
    func testMain() {
        let input = "[{ \"name\" : \"KIM JUNG\", \"level\" : 5, \"married\" : true }, 4, false, \"sd, true, {\"dsf\" : 4} f\"]"
//        let input = "{ \"name\" : \"KIM JUNG\", \"level\" : 5, \"married\" : true }"
        // 입력값을 분류해주는 구조체 선언
        let classifier = Classifier()
        // 입력값을 JSON 스타일로 나눔
        guard let separatedLetters = classifier.surveyLettersByJSON(letters: input) else {
            print("잘못된 입력")
            return ()
        }
        
        // JSON 구조체 선언
        let json = JSON()
        // JSON Data 생성
        guard let dataOfJSON = json.transformLetterToJSON(letters: separatedLetters) else {
            return ()
        }
        
        // 출력 구조체 선언
        let outputView = OutputView()
        outputView.printCountOfTypes(json: dataOfJSON)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
