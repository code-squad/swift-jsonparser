//
//  JSONArray.swift
//  JSONParser
//
//  Created by 윤지영 on 25/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONArray: JSONDataForm {
    private let jsonArray: [JSONValue]

    init(_ jsonArray: [JSONValue]) {
        self.jsonArray = jsonArray
    }

    var typeName: String {
        return JSONValue.array(self).typeName
    }

    var totalCount: Int {
        return jsonArray.count
    }

    func countType() -> [String : Int] {
        var typeCount: [String: Int] = [:]
        for jsonValue in self.jsonArray {
            typeCount[jsonValue.typeName] = (typeCount[jsonValue.typeName] ?? 0) + 1
        }
        return typeCount
    }

}
