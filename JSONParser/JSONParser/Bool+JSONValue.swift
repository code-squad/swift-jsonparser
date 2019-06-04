//
//  Bool+JSONValue.swift
//  JSONParser
//
//  Created by BLU on 2019. 6. 5..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

extension Bool: JSONValue {
    var typeDescription: String {
        return "부울"
    }
}
