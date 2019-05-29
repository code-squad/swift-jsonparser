//
//  TypeDictionary.swift
//  JSONParser
//
//  Created by jang gukjin on 09/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TypeDictionary: Json {
    private(set) var json = [String:Json]()
    
    init (json: String) {}
    
    init (json: [String:Json]) {
        self.json = json
    }
}

