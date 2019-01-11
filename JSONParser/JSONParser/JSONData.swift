//
//  JSONData.swift
//  JSONParser
//
//  Created by Elena on 24/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol JSONDataForm: JSONType {
    var totalCount: Int { get }
    func countValue() -> [String: Int]
}


protocol JSONType {
    var typeName: String { get }
}

extension String: JSONType {
    var typeName: String {
        return "문자열"
    }
}

extension Int: JSONType {
    var typeName: String {
        return "숫자"
    }
}

extension Bool: JSONType {
    var typeName: String {
        return "부울"
    }
}
