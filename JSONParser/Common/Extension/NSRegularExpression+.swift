//
//  Expression.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 5. 11..
//  Copyright © 2018년 JK. All rights reserved.
//
import Foundation

extension NSRegularExpression {
    convenience init(pattern : String) {
        try! self.init(pattern: pattern, options: [])
    }
}
