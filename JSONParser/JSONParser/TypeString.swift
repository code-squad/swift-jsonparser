//
//  TypeString.swift
//  JSONParser
//
//  Created by jang gukjin on 03/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TypeString: ElementType {
    private(set) var json : String
    
    init (json: String) {
        self.json = json
    }
    
    func countType(jsonDatas: [Json]) -> Int {
        var countString = 0
        for jsonData in jsonDatas {
            if ((jsonData.json as? TypeString) != nil) { countString += 1 }
        }
        return countString
    }
}
