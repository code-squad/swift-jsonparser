//
//  JsonValue.swift
//  JSONParser
//
//  Created by hw on 16/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonValue {
    
    var jsonValue : JsonParsable
    
    init (_ value : JsonParsable){
        self.jsonValue = value
    }
}
