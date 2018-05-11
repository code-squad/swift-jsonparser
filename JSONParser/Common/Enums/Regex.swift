//
//  Regex.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 5. 11..
//  Copyright © 2018년 JK. All rights reserved.
//

enum Regex {
    case number
    case string
    case boolean
    
    var description: String {
        switch self {
        case .number:
            return "[0-9]"
        case .string:
            return "\"[0-9][a-z][A-Z]|[a-z][A-Z][0-9]|[A-Z][a-z]|[0-9][a-z]|[a-z][0-9]|[0-9][A-Z]|[A-Z][0-9]|[a-z][A-Z]|[A-Z][a-z]|[a-z]|[A-Z]|[0-9]\""
        case .boolean:
            return "false|FALSE|true|TURE"
        }
    }
}
