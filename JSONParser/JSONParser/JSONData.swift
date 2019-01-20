//
//  JSONData.swift
//  JSONParser
//
//  Created by JINA on 08/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

class JSONData {
    var values: [JsonValue] = []
    
    init(_ values: JsonValue...) {
        self.values = values
    } 
}	
