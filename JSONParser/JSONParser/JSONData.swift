//
//  JSONData.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

enum JSONData {
    case IntegerValue(Int)
    case StringValue(String)
    case BoolValue(Bool)
    case ObjectValue(Dictionary<String, Any>)
}

