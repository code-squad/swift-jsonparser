//
//  Json.swift
//  JSONParser
//
//  Created by jang gukjin on 07/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Json {
    private(set) var json : ElementType
    
    init (json: ElementType) {
        self.json = json
    }
}
