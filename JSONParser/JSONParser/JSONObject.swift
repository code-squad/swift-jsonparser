//
//  JSONObject.swift
//  JSONParser
//
//  Created by 윤지영 on 25/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONObject: JSONDataForm {
    private let jsonObject: [String: JSONValue]

    init(_ jsonObject: [String: JSONValue]) {
        self.jsonObject = jsonObject
    }

    var typeName: String {
        return JSONValue.object(self).typeName
    }

    var totalCount: Int {
        return jsonObject.count
    }

    func countType() -> [String : Int] {
        var typeCount: [String: Int] = [:]
        for value in self.jsonObject.values {
            typeCount[value.typeName] = (typeCount[value.typeName] ?? 0) + 1
        }
        return typeCount
    }

}
