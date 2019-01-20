//
//  Protocol.swift
//  JSONParser
//
//  Created by JINA on 11/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

// 다양한 타입의 자료를 가질 수 있도록 프로토콜 생성
protocol JsonValue {
    func typeInfo() -> Self
}

extension Int: JsonValue {
    func typeInfo() -> Int {
        return self
    }
}

extension String: JsonValue {
    func typeInfo() -> String {
        return self
    }
}

extension Bool: JsonValue {
    func typeInfo() -> Bool {
        return self
    }
}
