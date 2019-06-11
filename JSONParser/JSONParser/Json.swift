//
//  Json.swift
//  JSONParser
//
//  Created by jang gukjin on 07/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol Json {
    var ment: String {get}
}

extension Bool: Json {
    var ment: String {
        get {
            return "부울"
        }
    }
}

extension Int: Json {
    var ment: String {
        get {
            return "숫자"
        }
    }
}

extension String: Json {
    var ment: String {
        get {
            return "문자열"
        }
    }
}

extension Dictionary: Json{
    var ment: String {
        get {
            return "객체"
        }
    }
}

extension Array: Json{
    var ment: String {
        get {
            return "배열"
        }
    }
}

