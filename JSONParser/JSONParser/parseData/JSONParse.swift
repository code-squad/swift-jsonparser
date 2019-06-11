//
//  JSONParser.swift
//  JSONParser
//
//  Created by 이희찬 on 11/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONParse {
    init(_ parsedData:[JSONValue], countNumber:countNumbers) {
        self.parsedJSONValue = parsedData
        self.countString = countNumber.string
        self.countInt = countNumber.int
        self.countBool = countNumber.bool
    }
    
    var parsedJSONValue:[JSONValue]
    var countString = 0
    var countInt = 0
    var countBool = 0
    
}


