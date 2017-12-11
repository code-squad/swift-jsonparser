//
//  InputView.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    static func readValues() throws -> JSONDataCountable & JSONDataMaker {
        if ProcessInfo.processInfo.arguments.count <= 1 {
            return try readValue()
        }
        
        
        return try readFile(in: CommandLine.arguments)
    }
    
    private static func readValue() throws -> JSONDataCountable & JSONDataMaker {
        print("분석할 JSON 데이터를 입력하세요.", terminator: "\n")
        
        guard let readValue = readLine() else {
            throw JSONError.emptyValue
        }
        
        return try JSONParser.analyzeJSONData(in: readValue)
    }
    
    private static func readFile(in arguments: [String]) throws -> JSONDataCountable & JSONDataMaker {
        let dir = FileManager.default.homeDirectoryForCurrentUser
        let baseFilePath = ProcessInfo.processInfo.environment["baseFilePath"]
        let path = "\(baseFilePath!)\(try Utility.validateFile(arguments[1]))"
        var readTexts: String = ""
        
        do {
            readTexts = try String(contentsOf: dir.appendingPathComponent(path)
, encoding: .utf8)
        } catch {
            throw JSONError.errorWhileReadingFile
        }

        return try JSONParser.analyzeJSONData(in: readTexts)
    }
}
