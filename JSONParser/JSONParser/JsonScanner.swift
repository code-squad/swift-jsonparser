//
//  JsonScanner.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 11. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JsonScanner {
    enum token: String{
        case STARTSQUAREBRACKET = "["
        case ENDSQUAREBRACKET = "]"
        case NUMBER = "[0-9]"
        case STRING = "[a-z,A-Z]"
        case BOOLEAN = "[true|false]"
        case COMMA = ","
    }
    
    func scanOfJsonValue(jsonValue: String) {
        for index in jsonValue.characters {
            //print(index)
            
        }
    }
    
    func getToken() {
        
    }
}
