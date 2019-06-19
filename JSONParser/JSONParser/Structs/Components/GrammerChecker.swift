//
//  GrammerChecker.swift
//  JSONParser
//
//  Created by 이동영 on 17/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct GrammerChecker: Checker {
    typealias T = String
    
    func check(format: String) throws {
        let maxDepth = format.filter{
            return ["[","{"].contains($0)
            }.count
        let isPosslible =  try checkList(format: format,depth: maxDepth) || ( try checkObject(format: format, depth: maxDepth) )
        guard isPosslible else {
            throw Error.unsupportedFormat
        }
        return 
    }
    
    private func checkObject(format: String, depth: Int = 0) throws -> Bool {
        let regex = Pattern.object
        return try check(string: format, pattern: regex)
    }
    
    private func checkList(format: String, depth: Int = 0) throws -> Bool {
        let regex = Pattern.list
        return try check(string: format, pattern: regex)
    }
    
    private func check(string: String, pattern: String) throws -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            throw Error.unsupportedRegex
        }
        if let match = regex.firstMatch(in: string, options: [], range: string.range) {
            let result = NSString.init(string:string).substring(with: (match.range))
            return result.range == string.range
        }
        return false
    }
    
}
// -MARK: - + Error
extension GrammerChecker {
    enum Error: Swift.Error,LocalizedError {
        case unsupportedFormat
        case unsupportedRegex
        
        var errorDescription: String? {
            switch self {
            case .unsupportedFormat:
                return "지원하지않는 JSON 형식입니다."
            case .unsupportedRegex:
                return "정규표현식 형식이 올바르지 않습니다."
            }
            
        }
    }
}
