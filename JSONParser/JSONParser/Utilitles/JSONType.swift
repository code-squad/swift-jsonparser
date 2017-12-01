//
//  JSONType.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 15..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

enum JSONType {
    case intType(Int)
    case boolType(Bool)
    case stringType(String)
    case arrayType(JSONArray)
    case objectType(JSONObject)
}
