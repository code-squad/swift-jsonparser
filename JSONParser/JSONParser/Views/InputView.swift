//
//  InputView.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    static func readValues(_ arguments: [String]) throws -> JSONDataCountable & JSONDataMaker {
        if arguments.count <= 1 {
            return try readValue()
        }
        
        let filePath = try Utility.makeFileIOPath(in: arguments)
        return try readFile(in: filePath.0)
    }
    
    private static func readValue() throws -> JSONDataCountable & JSONDataMaker {
        print("분석할 JSON 데이터를 입력하세요.", terminator: "\n")
        
        guard let readValue = readLine() else {
            throw JSONError.emptyValue
        }
        
        return try JSONParser.analyzeJSONData(in: readValue)
    }
    
    private static func readFile(in filePath: String) throws -> JSONDataCountable & JSONDataMaker {
        let dir = FileManager.default.homeDirectoryForCurrentUser
        var readTexts: String = ""
        
        do {
            readTexts = try String(contentsOf: dir.appendingPathComponent(filePath)
, encoding: .utf8)
        } catch {
            throw JSONError.errorWhileProcessingFile
        }

        return try JSONParser.analyzeJSONData(in: readTexts)
    }
}
