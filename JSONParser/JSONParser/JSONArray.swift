//
//  JSONData.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 13..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONArray: JSONData {
    private (set) var jsonArray: [JSONType]
    
    init(_ value: [JSONType]) {
        self.jsonArray = value
    }
    
    func analyzeData() -> JSONAnalysisData {
        let jsonData = JSONAnalysisData(jsonArray)
        return jsonData
    }
}
