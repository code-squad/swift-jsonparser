//
//  jsonParser.swift
//  JSONParser
//
//  Created by 김장수 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    private var json: String
    
    init(input: String) {
        self.json = input
    }
    
    func dataSet(of json: String) -> (string: Int, int: Int, bool: Int) {
        var dataSet = (string: 0, int: 0, bool: 0)
        
        return dataSet
    }
}
