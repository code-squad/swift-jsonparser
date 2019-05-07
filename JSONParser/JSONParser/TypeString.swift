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
    
    func countType(jsonDatum: Json) -> String{
        let stringMent = "문자열 "
        if (jsonDatum as? TypeString) != nil { return stringMent }
        else { return "" }
    }
}
