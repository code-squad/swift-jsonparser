//
//  JSONData.swift
//  JSONParser
//
//  Created by JINA on 08/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONData {
    private var typeBoolean: Int
    private var typeString: Int
    private var typeNumber: Int
    
    init(typeBoolean: Int, typeString: Int, typeNumber: Int){
        self.typeBoolean = typeBoolean
        self.typeString = typeString
        self.typeNumber = typeNumber
    }
    
    var data: [String:Int] {
        return ["부울":typeBoolean,"문자열":typeString,"숫자":typeNumber]
    }
    
    static func makeJSON(from splitInput: [String]) -> JSONData {
        let typeBoolean = RegularExpression.bringData(from: splitInput, regex: "(false|true)")
        let typeString = RegularExpression.bringData(from: splitInput, regex: "\"{1}+[A-Z0-9a-z]+\"{1}")
        let typeNumber = splitInput.count - (typeBoolean.count + typeString.count)
        
        let data = JSONData.init(typeBoolean: typeBoolean.count, typeString: typeString.count, typeNumber: typeNumber)
        return data
    }
    
}


