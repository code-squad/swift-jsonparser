//
//  Converter.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/27/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Converter {
    static func stringToJson (_ valueEntered: String) -> [JsonType] {
        let json = JsonParser.parseJson(valueEntered)
        
        return json
    }
}
