//
//  JSONArrayFormat.swift
//  JSONParser
//
//  Created by 이희찬 on 03/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation
struct FormatItem {
    
    static let JSONArray = CharacterSet(charactersIn: "[]")
    static let JSONArrayContainerLeft = "["
    static let JSONArrayContainerRight = "]"
    static let JSONObject = CharacterSet(charactersIn: "{}")
    static let JSONObjectContainerLeft = "{"
    static let JSONObjectContainerRight = "}"
    static let blank:Character = " "
    static let DoubleQuotationMark = CharacterSet(charactersIn: "\"")
    static let elementSperator = ","
    
}
