//
//  GrammerChecker.swift
//  JSONParser
//
//  Created by yuaming on 2017. 12. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct GrammerChecker {
    static func compareJSONDataValue(_ jsonData: [JSONData]) -> Bool {
        return jsonData.filter{ $0 == JSONData.null ? true : false }.count > 0
    }
}
