//
//  JsonNumber.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 19..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonNumber: JsonType {
    private let _data : Double
    
    init(number:String) {
        self._data = Double(number) ?? 0
    }
    
    func data() -> Double {
        return self._data
    }
}
