//
//  JSONParser.swift
//  JSONParser
//
//  Created by 이희찬 on 11/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol countable {
    var countNumbers:countNumbers { get }
}

struct JSONParse:countable {
    init(_ parsedData:[JSONValue], countNumbers:countNumbers) {
        self.parsedJSONValue = parsedData
        self.countString = countNumbers.string
        self.countInt = countNumbers.int
        self.countBool = countNumbers.bool
    }
    
    var countNumbers:countNumbers {
        return (self.countString, self.countInt, self.countBool)
    }
    
    private var parsedJSONValue:[JSONValue]
    private var countString = 0
    private var countInt = 0
    private var countBool = 0
    
}


