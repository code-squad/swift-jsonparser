//
//  TypeInt.swift
//  JSONParser
//
//  Created by jang gukjin on 03/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TypeInt: ElementType {
    private(set) var json : Int
    
    init (json: String) {
        self.json = Int(json) ?? 0
    }
    
    func countType(jsonDatas: [Json]) -> (ment: String, value: Int) {
        let intMent = "숫자 "
        var countInt = 0
        for jsonData in jsonDatas {
            if ((jsonData.json as? TypeInt) != nil) { countInt += 1 }
        }
        return (ment: intMent, value: countInt)
    }
}
