//
//  JsonListParsingStrategy.swift
//  JSONParser
//
//  Created by 이동영 on 31/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonListParsingStrategy: JsonParsingStrategy {
    
    func parse(tokens: [Token]) -> JsonValue {
        let converter = TokenConverter()
        var result = JsonList()
        for token in tokens {
            guard let jsonValue = converter.convert(before: token) else { continue }
            result.append(jsonValue)
        }
        return result
    }
}
