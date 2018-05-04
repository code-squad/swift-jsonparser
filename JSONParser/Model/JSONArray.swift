//
//  JSONArray.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 4. 26..
//  Copyright © 2018년 JK. All rights reserved.
//

struct JSONArray: JSON {
    private let jsonGenertor = JSONGenerator()
    var jsonType: JSONType
    
    init?(_ jsonType: JSONType) {
        self.jsonType = jsonType
        self.jsonGenertor.upwrapJSON(jsonType)
    }
    
    func descriptionShow() -> String {
        return self.jsonGenertor.descriptionMake()
    }
}
