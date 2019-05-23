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
        self.scanner = Scanner(string: "[ \"Hello, World!\", 4, true ]")
    }
    
    func testNext(){
        XCTAssertEqual(try self.scanner.next(), "[")
        XCTAssertEqual(try self.scanner.next(), " \"Hello, World!\",")
        XCTAssertEqual(try self.scanner.next(), " 4,")
        XCTAssertEqual(try self.scanner.next(), " true ")
        XCTAssertEqual(try self.scanner.next(), "]")
    }
    
}

