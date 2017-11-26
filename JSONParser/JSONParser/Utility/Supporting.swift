//
//  Supporting.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 26..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

protocol JSONSupporting {
    
}

extension JSONSupporting {
    func removeBrace(_ value: String) -> String {
        var rawJSON = value
        rawJSON.removeFirst()
        rawJSON.removeLast()
        return rawJSON
    }
    
}
