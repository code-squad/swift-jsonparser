//
//  JSON.swift
//  JSONParser
//
//  Created by BLU on 2019. 6. 2..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

protocol JSONValue {
    var typeDescription: String { get }
}

extension String: JSONValue {
    var typeDescription: String {
        return "문자열"
    }
}

extension Int: JSONValue {
    var typeDescription: String {
        return "숫자"
    }
}

extension Bool: JSONValue {
    var typeDescription: String {
        return "부울"
    }
}
