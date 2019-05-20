//
//  ScannerTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 20/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class ScannerTests: XCTestCase {

    var scanner : Scanner!
    
    override func setUp() {
        self.scanner = Scanner(context: .Array, elements: "\"Hello, World!\"".map{$0}, curser: 0 )
    }
    
    func testScan(){
        XCTAssertEqual(self.scanner.scan(), "\"Hello, World!\"")
    }

   

}

