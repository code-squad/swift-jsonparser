//
//  JSONType.swift
//  JSONParser
//
//  Created by 윤지영 on 23/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public enum JSONValue {
    case string(String)
    case int(Int)
    case bool(Bool)
    case object([String : JSONValue])
    case array([JSONValue])
}

protocol JSONDataForm {
    var typeName: typeName { get }
    var totalCount: Int { get }
    func countType() -> [String: Int]
}
