//
//  File.swift
//  JSONParser
//
//  Created by 김장수 on 12/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct SwiftJSON: JSONData {
    private var ints: [Int]
    private var bools: [Bool]
    private var strings: [String]
    
    init(ints: [Int], bools: [Bool], strings: [String]) {
        self.ints = ints
        self.bools = bools
        self.strings = strings
    }
    
    func getDTO() -> DTO {
        return DTO(json: ["ints": self.ints, "bools": self.bools, "strings": self.strings])
    }
}

