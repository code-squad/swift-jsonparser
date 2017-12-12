//
//  Utility.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct Utility {
    static func removeFromFirstToEnd(in value: String) -> String {
        var _value: String = value
        _value.removeFirst()
        _value.removeLast()
        return _value
    }
    
    static func makeFileIOPath(in arguments: [String]) throws -> (String, String) {
        let base = ProcessInfo.processInfo.environment["baseFilePath"]
        let inPath: String
        let outPath: String
        
        print("count : \(arguments.count)")
        print("arguments : \(arguments)")
        
        switch arguments.count {
        case 2:
            inPath = "\(base!)\(try validateFile(arguments[1]))"
            outPath = "\(base!)result.json"
            return (in: inPath, out: outPath)
        case 3:
            inPath = "\(base!)\(try validateFile(arguments[1]))"
            outPath = "\(base!)\(try validateFile(arguments[2]))"
            return (in: inPath, out: outPath)
        default:
            throw JSONError.emptyArgument
        }
    }
    
    static func validateFile(_ fileName: String) throws -> String {
        guard !fileName.isEmpty else {
            throw JSONError.errorWhileProcessingFile
        }
        
        guard fileName.hasSuffix("json") else {
            var _fileNames: [String]  = fileName.splitUnits(seperator: ".")
            _fileNames.removeLast()
            _fileNames.append(".json")
            return _fileNames.joined()
        }
        
        return fileName
    }
}
