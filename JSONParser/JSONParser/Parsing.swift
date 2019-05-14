//
//  Parsing.swift
//  JSONParser
//
//  Created by jang gukjin on 15/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol Parsing {
    func parsingData(beforeData : String) throws -> Json
}

extension Parsing where Self: Json {
    func parsingData(beforeData: String) -> Json {
        var convertedElement: Json
        let afterData = beforeData.trimmingCharacters(in: .whitespacesAndNewlines)
        if afterData.contains("\"") {
            convertedElement = TypeString.init(json: afterData)
        } else if let _ = Int(afterData) {
            convertedElement = TypeInt.init(json: afterData)
        } else if let _ = Bool(afterData) {
            convertedElement = TypeBool.init(json: afterData)
        } else {
            convertedElement = TypeString.init(json: afterData)
        }
        return convertedElement
    }
}
