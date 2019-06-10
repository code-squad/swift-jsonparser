//
//  JSONDataCount.swift
//  JSONParser
//
//  Created by JieunKim on 06/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONDataCount {
    static func NEWJSONTypeCount(arrayData: [JSONDataType]) throws -> [String: Int] {
        var counts: [String: Int] = [:]
        for item in arrayData {
            counts[item.typeDescription] = (counts[item.typeDescription] ?? 0) + 1
        }
        return counts
    }
}


