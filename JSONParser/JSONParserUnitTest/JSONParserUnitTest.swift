//
//  JSONParserUnitTest.swift
//  JSONParserUnitTest
//
//  Created by hw on 13/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class JSONParserUnitTest: XCTestCase {

    func testCheckInvalidJsonObjectFormat(){
        var testInput = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        XCTAssertTrue(checkInvalidJsonObjectFormat(testInput), "error")
        
    }
    
    func checkInvalidJsonObjectFormat(_ input: String) -> Bool{
        var isJsonObject = true
        isJsonObject &= checkPrefixSuffixFormat(input)
        isJsonObject &= checkJsonObjectKeyValueFormat(input)
        return isJsonObject
    }
    
    func checkPrefixSuffixFormat(_ input: String) -> Bool {
        var isJsonObject = true
        isJsonObject &= input.hasPrefix("{") && input.hasSuffix("}")
        return isJsonObject
    }
    
    func checkJsonObjectKeyValueFormat(_ input: String) -> Bool {
        var isJsonObject = true
        let filterPattern = ["{","}"]
        let removeFirstAndLastCharacter = input.filter{(value) in return !filterPattern.contains(String(value))}
        
        let keyValuePreSeperated = removeFirstAndLastCharacter.components(separatedBy: ",").map{ (value) in return //
            String(value).components(separatedBy: ":").map{value in return String(value)}}
        for element in keyValuePreSeperated {
            isJsonObject &= element.count == 2 ? true : false
        }
        return isJsonObject
    }
    
    
   

    
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
   

}
