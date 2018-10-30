//
//  jsonParser.swift
//  JSONParser
//
//  Created by 김장수 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    private var text: String
    
    init(input: String) {
        self.text = input
    }
    
    func dataSet(of text: String) -> [String: Int] {
        let dataSet = ["문자열": 0, "숫자": 0, "부울": 0]
        
        return dataSet
    }
}
