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
    
    static func validateFile(_ fileName: String) throws -> String {
        if fileName.isEmpty {
            throw JSONError.errorWhileReadingFile
        }
        
        if !fileName.hasSuffix("json") {
            throw JSONError.notJSONFile
        }
        
        return fileName
    }
}
