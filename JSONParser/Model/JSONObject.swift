//
//  JSONObject.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 4. 26..
//  Copyright © 2018년 JK. All rights reserved.
//

struct JSONObjectArray: JSON {
    
    private let jsonGenertor = JSONGenerator()
    private let jsonObjectArray: JSONType
    
    init?(_ jsonType: JSONType)  {
        self.jsonObjectArray = jsonType
        self.jsonGenertor.upwrapJSON(jsonObjectArray)
    }
    
    func descriptionShow() -> String {
        return self.jsonGenertor.descriptionMake()
    }
}
