//
//  JSONData.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct JSONData: Parsable {
    var numbers: [Int]
    var characters: [String]
    var booleans: [Bool]
    
    var total: Int {
        return self.numbers.count + self.characters.count + self.booleans.count
    }
}
