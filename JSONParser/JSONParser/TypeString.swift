//
//  TypeString.swift
//  JSONParser
//
//  Created by jang gukjin on 03/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TypeString: Json {
    private(set) var json : String
    
    init (json: String) {
        self.json = json
    }
    
    func countType(jsonData: [Json]) -> (ment: String, value: Int) {
        let stringMent = "문자열 "
        var countString = 0
        for jsonDatum in jsonData {
            if ((jsonDatum as? TypeString) != nil) { countString += 1 }
        }
        return (ment: stringMent, value: countString)
    }
}
