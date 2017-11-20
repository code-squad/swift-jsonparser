//
//  JsonScanner.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 11. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JsonScanner {
    
    func scanOfJsonValue(jsonValue: String) {
        for index in jsonValue.characters {
            print(index)
        }
    }
}
