//
//  GrammarCheckerTest.swift
//  JSONParserTests
//
//  Created by TaeHyeonLee on 2017. 11. 10..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest

@testable import JSONParser

class GrammarCheckerTest: XCTestCase {
    var grammarChecker : GrammarChecker!
    var objectTester : String = "{ \"name\": \"KIM JUNG\", \"alias\" :\"JK\", \"level\" : 5, \"married\" : true }"
    var arrayTester : String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
    
    override func setUp() {
        super.setUp()
        grammarChecker = GrammarChecker()
    }
    
    override func tearDown() {
        super.tearDown()
        grammarChecker = nil
    }

    func testObject() {
        let tester : String = "{ \"name\": \"KIM JUNG\", \"alias\" :\"JK\", \"level\" : 5, \"married\" : true }"
        let stringPattern : String = "[\\s]?\"[a-zA-Z\\d\\s]+\"[\\s]?"
        let intPattern : String = "[\\s]?\\d+[\\s]?"
        let boolPattern : String = "[\\s]?(true|false)[\\s]?"
        let dictionaryPattern : String = "\(stringPattern):(\(stringPattern)|\(intPattern)|\(boolPattern))"
        let objectPattern : String = "[\\s]?[\\{][\\s]?(\(dictionaryPattern)[,]?)+[\\s]?[\\}][\\s]?"
        let objectChecker : NSRegularExpression = try! NSRegularExpression.init(pattern: objectPattern, options: [])
        let result = objectChecker.numberOfMatches(in: tester, options: [], range: NSRange(location:0, length:tester.count))
        XCTAssertEqual(result, 1)
    }
    
    func testArray() {
        let tester : String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false , { \"name\": \"KIM JUNG\", \"alias\" :\"JK\", \"level\" : 5, \"married\" : true } ]"
        let stringPattern : String = "[\\s]?\"[a-zA-Z\\d\\s]+\"[\\s]?"
        let intPattern : String = "[\\s]?\\d+[\\s]?"
        let boolPattern : String = "[\\s]?(true|false)[\\s]?"
        let dictionaryPattern : String = "\(stringPattern):(\(stringPattern)|\(intPattern)|\(boolPattern))"
        let objectPattern : String = "[\\s]?[\\{][\\s]?(\(dictionaryPattern)[,]?)+[\\s]?[\\}][\\s]?"
        let arrayPattern : String = "[\\s]?[\\[][\\s]?((\(stringPattern)|\(intPattern)|\(boolPattern)|\(objectPattern))[,]?)+[\\s]?[\\]][\\s]?"
        let arrayChecker : NSRegularExpression = try! NSRegularExpression.init(pattern: arrayPattern, options: [])
        let result = arrayChecker.numberOfMatches(in: tester, options: [], range: NSRange(location:0, length:tester.count))
        XCTAssertEqual(result, 1)
    }
    
    func testIsArrayPattern() {
        XCTAssertTrue(grammarChecker.isArrayPattern(target: arrayTester))
    }
    
    func testIsObjectPattern() {
        XCTAssertTrue(grammarChecker.isObjectPattern(target: objectTester))
    }

}
