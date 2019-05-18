//
//  Json.swift
//  JSONParser
//
//  Created by jang gukjin on 07/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol Json {
    init (json: String) throws
}
extension Json where Self == TypeDictionary {
    var json: [String:Json] {
        return [:]
    }
    
//    init (json: [String:Json]) {
//        self = json
//    }
}
