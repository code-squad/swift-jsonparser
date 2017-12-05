//
//  JSONObject.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 27..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONObject {
    private var jsonObject: [String: JSONData]
    
    init(data: [String: JSONData]) {
        self.jsonObject = data
    }
}

extension JSONObject: JSONDataMaker {
    func makeJSONData() -> JSONData {
        return JSONData.object(self.jsonObject)
    }
}

extension JSONObject: JSONDataCountable {
    var totalCount: Int {
        return self.jsonObject.values.count
    }
    
    var objectCount: Int {
        return self.jsonObject.values.flatMap{ $0.object }.count
    }
    
    var boolCount: Int {
        return self.jsonObject.values.flatMap{ $0.bool }.count
    }
    
    var numberCount: Int {
        return self.jsonObject.values.flatMap{ $0.number }.count
    }
    
    var stringCount: Int {
        return self.jsonObject.values.flatMap{ $0.string }.count
    }
    
    var arrayCount: Int {
        return self.jsonObject.values.flatMap{ $0.array }.count
    }
}
