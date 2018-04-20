//
//  JSONParserUnitTest.swift
//  JSONParserUnitTest
//
//  Created by Jung seoung Yeo on 2018. 4. 19..
//  Copyright © 2018년 JK. All rights reserved.
//

import XCTest

class JSONParserUnitTest: XCTestCase {
    
    let josnFormat: String = "[ 10, 21, 4, 314, 99, 0, 72 ]"
    let jsonFormatRemoveSpace: String = "[10,21,4,314,99,0,72]"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK : String+
    
    //String+ : 공백 제거
    func test_removeSpacePass() {
        let expectValue = josnFormat.trim()
        XCTAssertEqual(jsonFormatRemoveSpace, expectValue)
    }
    
    //String+ : 공백이 제거가 안된 값이랑 비교
    func test_removeSplaceNoPass() {
        let expectValue = josnFormat.trim()
        XCTAssertNotEqual(josnFormat, expectValue)
    }
    
}
