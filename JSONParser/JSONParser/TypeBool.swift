//
//  TypeBool.swift
//  JSONParser
//
//  Created by jang gukjin on 03/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TypeBool: Json {
    private(set) var json : Bool
    
    init (json: String) {
        self.json = Bool(json) ?? false
    }
}
