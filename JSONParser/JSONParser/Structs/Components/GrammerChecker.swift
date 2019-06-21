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
    
    func check(format: String) -> Bool {
        let maxDepth = format.filter{
            return ["[","{"].contains($0)
            }.count
        return self.checkObject(format: format, depth: maxDepth) || self.checkList(format: format, depth: maxDepth)
    }
    
    private func checkObject(format: String, depth: Int = 0) -> Bool {
        let regex = Pattern.object
        return check(string: format, pattern: regex)
    }
    
    private func checkList(format: String, depth: Int = 0) -> Bool {
        let regex = Pattern.list
        return check(string: format, pattern: regex)
    }
    
    private func check(string: String, pattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return false
        }
        let matchRange = regex.rangeOfFirstMatch(in: string, options: [], range: string.range)
        return matchRange == string.range
    }
    
}
// -MARK: - + Error
extension GrammerChecker {
    enum Error: Swift.Error {
        case unsupportedFormat
        case unsupportedRegex
        
        var localizedDescription: String {
            switch self {
            case .unsupportedFormat:
                return "지원하지않는 JSON 형식입니다."
            case .unsupportedRegex:
                return "정규표현식 형식이 올바르지 않습니다."
            }
        }
    }
}
