//
//  JSONType.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

protocol JSONType {
    var stringCounter: Int { get }
    var intCounter: Int { get }
    var boolCounter: Int { get }
    var objectCounter : Int { get }
    var arrayCounter : Int { get }
    var container: String { get }
}

extension JSONType {
    var totalCounter: Int {
        return stringCounter + intCounter + boolCounter + objectCounter + arrayCounter
    }
}
