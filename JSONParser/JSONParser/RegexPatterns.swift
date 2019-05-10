//
//  DataTypesSupportedByJSON.swift
//  JSONParser
//
//  Created by 이동영 on 11/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum RegexPatterns: String {
    case String = "\"[\\S\\s]+\""
    case Number = "-?[\\d]+"
    case Boolean = "(true|false)"
    case Array = "^\\[[\\S\\s]+\\]$"
    
    func getRegex() throws -> NSRegularExpression {
        guard let regex = try? NSRegularExpression.init(pattern: self.rawValue, options: []) else { throw Exception.RegexConversionFail }
        return regex
    }
    
}
