//
//  Json.swift
//  JSONParser
//
//  Created by jang gukjin on 07/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol Json {
    static var ment: String {get}
}

extension Bool: Json {
    static var ment: String {
        return "부울"
    }
}

extension Int: Json {
    static var ment: String {
        return "숫자"
    }
}

extension String: Json {
    static var ment: String {
        return "문자열"
    }
}

extension Dictionary: Json{
    static var ment: String {
        return "객체"
    }
}

extension Array: Json{
    static var ment: String {
        return "배열"
    }
}

