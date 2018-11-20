//
//  File.swift
//  JSONParser
//
//  Created by 김장수 on 12/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct ArrayJSONData: Parsable {
    private let elements: [String]
    
    init(elements: [String]) {
        self.elements = elements
    }
    
    func getDTO() -> DTO {
        return DTO(json: self.elements)
    }
}

struct ObjectJSONData: Parsable {
    private let elements: [String]
    
    init(elements: [String]) {
        self.elements = elements
    }
    
    func getDTO() -> DTO {
        return DTO(json: self.elements)
    }
}
