//
//  TypeBool.swift
//  JSONParser
//
//  Created by jang gukjin on 03/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TypeBool: ElementType {
    private(set) var json : Bool
    
    init (json: String) {
        self.json = Bool(json) ?? false
    }
    
    func countType(jsonDatas: [Json]) -> (ment: String, value: Int) {
        let boolMent = "부울 "
        var countBool = 0
        for jsonData in jsonDatas {
            if ((jsonData.json as? TypeBool) != nil) { countBool += 1}
        }
        return (ment: boolMent, value: countBool)
    }
}
