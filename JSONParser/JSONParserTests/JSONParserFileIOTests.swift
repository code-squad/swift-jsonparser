//
//  JSONParserFileIOTests.swift
//  JSONParserTests
//
//  Created by yuaming on 2017. 12. 12..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest

class JSONParserFIleIOTests: XCTestCase {
    func test_파일_읽어오는_경로확인() {
        let inPath = "dev/workspace/json-parser/JSONParser/JSONFiles/input.json"
        let arguments = ["/Users/yuaming/Library/Developer/Xcode/DerivedData/JSONParser-hevzpabfkbvqisbloqbyfhcbcsse/Build/Products/Debug/JSONParser", "input.json"]
        XCTAssertTrue(try Utility.makeFileIOPath(in: arguments).0 == inPath)
    }
    
    func test_파일_출력_경로_임의지정() {
        let outPath = "dev/workspace/json-parser/JSONParser/JSONFiles/result.json"
        let arguments = ["/Users/yuaming/Library/Developer/Xcode/DerivedData/JSONParser-hevzpabfkbvqisbloqbyfhcbcsse/Build/Products/Debug/JSONParser", "input.json"]
        XCTAssertTrue(try Utility.makeFileIOPath(in: arguments).1 == outPath)
    }
    
    func test_파일_출력_경로확인() {
        let outPath = "dev/workspace/json-parser/JSONParser/JSONFiles/output.json"
        let arguments = ["/Users/yuaming/Library/Developer/Xcode/DerivedData/JSONParser-hevzpabfkbvqisbloqbyfhcbcsse/Build/Products/Debug/JSONParser", "input.json", "output.json"]
        XCTAssertTrue(try Utility.makeFileIOPath(in: arguments).1 == outPath)
    }
    
    func test_파일_json형식_아닐_경우() {
        let outPath = "dev/workspace/json-parser/JSONParser/JSONFiles/output.json"
        let arguments = ["/Users/yuaming/Library/Developer/Xcode/DerivedData/JSONParser-hevzpabfkbvqisbloqbyfhcbcsse/Build/Products/Debug/JSONParser", "input.json", "output.js"]
        XCTAssertTrue(try Utility.makeFileIOPath(in: arguments).1 == outPath)
    }
    
    func test_파일_읽기() {
        let arguments = ["/Users/yuaming/Library/Developer/Xcode/DerivedData/JSONParser-hevzpabfkbvqisbloqbyfhcbcsse/Build/Products/Debug/JSONParser", "input.json"]
        XCTAssertTrue(try InputView.readValues(arguments).totalCount == 4)
        XCTAssertTrue(try InputView.readValues(arguments).stringCount == 2)
        XCTAssertTrue(try InputView.readValues(arguments).arrayCount == 1)
        XCTAssertTrue(try InputView.readValues(arguments).numberCount == 1)
    }
}
