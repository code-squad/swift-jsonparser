//
//  Json.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 6..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

protocol Jsonable {
    func countData() -> (Int,Int,Int,Int,Int)
    func generateData() -> String
}

enum JsonType:Equatable {
    case string(String)
    case int(Int)
    case bool(Bool)
    case object([String:JsonType])
    case array([JsonType])
}
