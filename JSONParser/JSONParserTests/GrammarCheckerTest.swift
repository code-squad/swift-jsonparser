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
    // object
    var objectTester : String = "{ \"name\": \"KIM JUNG\", \"alias\" :\"JK\", \"level\" : 5, \"married\" : true }"
    var errorTesterForObject : String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
    let nestedObjectTester : String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"], \"test\" : { \"test\" : \"tester\" } }"
    // array
    var arrayTester : String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
    var errorTesterForArray : String = "[ \"name\" : \"KIM JUNG\" ]"
    let nestedArrayTester : String = "[ { \"test\" : \"tester\" }, [1,2,3] ]"
    
    override func setUp() {
        super.setUp()
        grammarChecker = GrammarChecker()
    }
    
    override func tearDown() {
        super.tearDown()
        grammarChecker = nil
    }
    
    func testObject() {
        let stringPattern : String = "[\\s]?\"[a-zA-Z\\d\\s]+\"[\\s]?"
        let intPattern : String = "[\\s]?\\d+[\\s]?"
        let boolPattern : String = "[\\s]?(true|false)[\\s]?"
        let dictionaryPattern : String = "\(stringPattern):(\(stringPattern)|\(intPattern)|\(boolPattern))"
        let objectPattern : String = "[\\s]?[\\{][\\s]?(\(dictionaryPattern)[,]?)+[\\s]?[\\}][\\s]?"
        let arrayPattern : String = "[\\s]?[\\[][\\s]?((\(stringPattern)|\(intPattern)|\(boolPattern)|\(objectPattern))[,]?)+[\\s]?[\\]][\\s]?"
        
        let nestedDictionaryPattern : String = "\(stringPattern):(\(stringPattern)|\(intPattern)|\(boolPattern)|\(objectPattern)|\(arrayPattern))"
        let nestedObjectPattern : String = "[\\s]?[\\{][\\s]?((\(nestedDictionaryPattern))[,]?)+[\\s]?[\\}][\\s]?"
        
        let objectChecker : NSRegularExpression = try! NSRegularExpression.init(pattern: nestedObjectPattern, options: [])
        let objectResult = objectChecker.matches(in: objectTester, options: [], range: NSRange(location:0, length:objectTester.count))
        let result1 = objectResult.map {String(objectTester[Range($0.range, in: objectTester)!])}
        XCTAssertEqual(result1.count, 1)
        XCTAssertEqual(result1[0], "{ \"name\": \"KIM JUNG\", \"alias\" :\"JK\", \"level\" : 5, \"married\" : true }")
        
        let nestedObjectChecker : NSRegularExpression = try! NSRegularExpression.init(pattern: nestedObjectPattern, options: [])
        let nestedObjectMatches = nestedObjectChecker.matches(in: nestedObjectTester, options: [], range: NSRange(location:0, length:nestedObjectTester.count))
        let nestedObjectResult = nestedObjectMatches.map {String(nestedObjectTester[Range($0.range, in: nestedObjectTester)!])}
        XCTAssertEqual(nestedObjectResult.count, 1)
        XCTAssertEqual(nestedObjectResult[0], "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"], \"test\" : { \"test\" : \"tester\" } }")
    }
    
    func testArray() {
        let stringPattern : String = "[\\s]?\"[a-zA-Z\\d\\s]+\"[\\s]?"
        let intPattern : String = "[\\s]?\\d+[\\s]?"
        let boolPattern : String = "[\\s]?(true|false)[\\s]?"
        let dictionaryPattern : String = "\(stringPattern):(\(stringPattern)|\(intPattern)|\(boolPattern))"
        let objectPattern : String = "[\\s]?[\\{][\\s]?(\(dictionaryPattern)[,]?)+[\\s]?[\\}][\\s]?"
        let arrayPattern : String = "[\\s]?[\\[][\\s]?((\(stringPattern)|\(intPattern)|\(boolPattern)|\(objectPattern))[,]?)+[\\s]?[\\]][\\s]?"
        
        let nestedDictionaryPattern : String = "\(stringPattern):(\(stringPattern)|\(intPattern)|\(boolPattern)|\(objectPattern)|\(arrayPattern))"
        let nestedObjectPattern : String = "[\\s]?[\\{][\\s]?((\(nestedDictionaryPattern))[,]?)+[\\s]?[\\}][\\s]?"
        let nestedArrayPattern : String = "[\\s]?[\\[][\\s]?((\(stringPattern)|\(intPattern)|\(boolPattern)|\(nestedObjectPattern)|\(arrayPattern))[,]?)+[\\s]?[\\]][\\s]?"
        
        let arrayChecker : NSRegularExpression = try! NSRegularExpression.init(pattern: nestedArrayPattern, options: [])
        let arrayResult = arrayChecker.matches(in: arrayTester, options: [], range: NSRange(location:0, length:arrayTester.count))
        
        let result = arrayResult.map {String(arrayTester[Range($0.range, in: arrayTester)!])}
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0], "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]")
        
        let nestedArrayChecker : NSRegularExpression = try! NSRegularExpression.init(pattern: nestedArrayPattern, options: [])
        let nestedArrayMatches = nestedArrayChecker.matches(in: nestedArrayTester, options: [], range: NSRange(location:0, length:nestedArrayTester.count))
        
        let nestedArrayResult = nestedArrayMatches.map {String(nestedArrayTester[Range($0.range, in: nestedArrayTester)!])}
        XCTAssertEqual(nestedArrayResult.count, 1)
        XCTAssertEqual(nestedArrayResult[0], "[ { \"test\" : \"tester\" }, [1,2,3] ]")
    }
    
    func testIsJSONPatternForArray() {
        XCTAssertNoThrow(try grammarChecker.isJSONPattern(target: arrayTester))
        XCTAssertThrowsError(try grammarChecker.isJSONPattern(target: errorTesterForArray))
    }
    
    func testIsJSONPatternForObject() {
        XCTAssertNoThrow(try grammarChecker.isJSONPattern(target: objectTester))
        XCTAssertThrowsError(try grammarChecker.isJSONPattern(target: errorTesterForObject))
    }

}
