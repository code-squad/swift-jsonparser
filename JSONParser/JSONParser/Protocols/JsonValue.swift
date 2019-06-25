//
//  JSONValue.swift
//  JSONParser
//
//  Created by 이동영 on 30/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JsonValue {
    
    func describeType() -> String
    
    func getJsonValue() -> String
    
    func serialize(indent: Int) -> String
}


extension JsonValue {
    
    func getJsonValue() -> String {
        return "\(self)"
    }
    
    func serialize(indent: Int) -> String {
        return "\(self)"
    }
}

