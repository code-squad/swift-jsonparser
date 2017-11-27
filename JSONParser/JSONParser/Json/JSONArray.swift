//
//  JSONAnalyzer.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONArray {
    private var jsonArray: [JSONData]
    
    init(data: [JSONData]) {
        self.jsonArray = data
    }
}

extension JSONArray: JSONDataMaker {
    func makeJSONData() -> JSONData {
        return JSONData.array(jsonArray)
    }
}

extension JSONArray: JSONDataCountable {
    var arrayCount: Int {
        return self.jsonArray.count
    }
    
    var boolCount: Int {
        return self.jsonArray.flatMap{ $0.bool }.count
    }
    
    var numberCount: Int {
        return self.jsonArray.flatMap{ $0.number }.count
    }
    
    var stringCount: Int {
        return self.jsonArray.flatMap{ $0.string }.count
    }
    
    var objectCount: Int {
        return self.jsonArray.flatMap{ $0.object }.count
    }
}
