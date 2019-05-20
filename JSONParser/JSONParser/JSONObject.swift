//
//  JSONObject.swift
//  JSONParser
//
//  Created by Daheen Lee on 20/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONObject {
    var keyValuePairs: [String : JSONValue]
    
    init() {
        keyValuePairs = [String : JSONValue]()
    }

}

extension JSONObject: JSONValue {
    static var typeDescription: String {
        return "객체"
    }
}
