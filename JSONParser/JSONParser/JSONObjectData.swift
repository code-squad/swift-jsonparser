//
//  JSONObjectData.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 27..
//  Copyright © 2017년 Napster. All rights reserved.
//

import Foundation

struct JSONObjectData {
    private (set) var jsonObject: [String:JSONType]
    
    init(_ value: [String:JSONType]) {
        self.jsonObject = value
    }
    
}
