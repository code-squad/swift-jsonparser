//
//  JsonParsable.swift
//  JSONParser
//
//  Created by hw on 16/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JsonParsable {
    func toString() -> String
}

extension String : JsonParsable {
    func toString() -> String {
        return self
    }
}

extension Int : JsonParsable {
    func toString() -> String {
        return String(self)
    }
}

extension Bool : JsonParsable {
    func toString() -> String {
        return String(self)
    }
}
