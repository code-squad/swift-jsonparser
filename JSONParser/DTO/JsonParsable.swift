//
//  JsonParsable.swift
//  JSONParser
//
//  Created by hw on 16/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JsonParsable : CustomStringConvertible{
    var description: String {get}
}

extension String : JsonParsable {
    var description : String {
        get {
            return self
        }
    }
}

extension Int : JsonParsable {
    var description : String {
        get {
            return String(self)
        }
    }
}

extension Bool : JsonParsable {
    var description : String {
        get {
            return String(self)
        }
    }
}
