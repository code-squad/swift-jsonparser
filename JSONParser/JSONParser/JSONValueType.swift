//
//  JSONValueType.swift
//  JSONParser
//
//  Created by CHOMINJI on 19/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JSONValueType {
    var type: String { get }
}

extension String: JSONValueType {
    var type: String {
        return "문자열"
    }
}

typealias Number = Int
extension Number: JSONValueType {
    var type: String {
        return "숫자"
    }
}

extension Bool: JSONValueType {
    var type: String {
        return "부울"
    }
}
