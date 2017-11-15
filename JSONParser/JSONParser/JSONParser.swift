//
//  JSONParser.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 13..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    private (set) var supportingJSON = JSONSupporting()

    func check(_ value: String?) throws -> String {
        guard let safeValue = value else {
            throw ErrorCode.invalidInputString
        }
        if safeValue.hasPrefix("[") {
            return safeValue
        } else if safeValue.hasPrefix("{"){
            return safeValue
        } else {
            throw ErrorCode.invalidJSONStandard
        }
    }
    
    func makeJSONData(_ value: String) throws -> JSONData {
        if value.hasPrefix("[") {
            let arrayJSON = try makeArrayJSONData(value)
            return arrayJSON
        } else {
            let objectJSON = makeObjectJSONData(value)
            return objectJSON
        }
    }
    
}


