//
//  JsonObjecr+JsonValue.swift
//  JSONParser
//
//  Created by 이동영 on 30/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

extension JsonObject: JsonValue {
    
    func describeType() -> String {
        return "객체"
    }

    func serialize(indent: Int = 0 ) -> String {
        let ws = String(repeating: "\t", count: indent)
        let elements = self.map { "\(ws)\t\($0.key) : \($0.value.serialize(indent: indent+1))"}.joined(separator: ",\n")
        return "\(ws){\n\(elements)\n\(ws)}"
    }
    
}

