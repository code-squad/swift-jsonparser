//
//  String+.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 4. 19..
//  Copyright © 2018년 JK. All rights reserved.
//
import Foundation

extension String {
    // 공백 제거
    func trim() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    func pattenMatching(_ patten: String) throws {
        let regex = try NSRegularExpression(pattern: patten, options: [])
        if !(regex.matches(in: self, options: [], range: NSMakeRange(0, self.count)).count > 0) {
            throw JSONPaserErorr.isRegex
        }
    }
}
