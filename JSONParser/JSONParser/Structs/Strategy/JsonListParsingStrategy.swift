//
//  JsonListParsingStrategy.swift
//  JSONParser
//
//  Created by 이동영 on 31/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonListParsingStrategy: JsonParsingStrategy {
    private let converter = TokenConverter()
    
    func parse(tokens: Array<Token>) -> JsonValue {
        var jsonList = JsonList()
        
        for token in tokens {
            guard let jsonValue = self.converter.convert(before: token) else { continue }
            jsonList.append(jsonValue)
        }
        return jsonList
    }
}
