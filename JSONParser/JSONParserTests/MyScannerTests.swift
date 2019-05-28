//
//  ScannerTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class MyScannerTests: XCTestCase {
    var scanner: Scanner!
    var characters = [Character]()
    
    func testNextNumber() {
        //Given
        self.scanner = MyScanner.init(string: "24")
        
        //When
        while self.scanner.hasNext() {
            self.characters.append(self.scanner.next()!)
        }
        
        //Then
        XCTAssertEqual(self.characters,["2","4"])
    }
    
    func testNextString() {
        //Given
        self.scanner = MyScanner.init(string: "\"Hi, Jk\"")
        
        //When
        while self.scanner.hasNext() {
            self.characters.append(self.scanner.next()!)
        }
        
        //Then
        XCTAssertEqual(self.characters, ["\"","H","i",","," ", "J","k","\""])
    }
    
    func testNextBool() {
        //Given
        self.scanner = MyScanner.init(string: "true")
        
        //When
        while self.scanner.hasNext() {
            self.characters.append(self.scanner.next()!)
        }
        
        //Then
        XCTAssertEqual(self.characters, ["t","r","u","e"])
    }
    
    func testNextInt() {
        //Given
        self.scanner = MyScanner.init(string: " ")
        
        //When
        while self.scanner.hasNext() {
            self.characters.append(self.scanner.next()!)
        }
        
        //Then
        XCTAssertEqual(self.characters, [" "])
    }
    
    func testNextThrowError() {
        //Given
        self.scanner = MyScanner.init(string: "")
        
        //Then
        XCTAssertEqual(self.scanner.next(), nil)
    }
}
