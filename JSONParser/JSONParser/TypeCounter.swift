//
//  TypeCounter.swift
//  JSONParser
//
//  Created by CHOMINJI on 24/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TypeCounter {
    
    static func count(of jsonValues: [JSONValueType]) -> (string: Int, number: Int, bool: Int) {
        
        let types = jsonValues.map { type(of: $0) }
        
        let countOfString = types.countType(of: String.self)
        let countOfNumber = types.countType(of: Number.self)
        let countOfBool = types.countType(of: Bool.self)
        
        let result = (countOfString, countOfNumber, countOfBool)
        return result
    }
}

extension Array {
    
    func countType<T>(of target: T) -> Int {
        
        return self.filter { $0 is T }.count
        
    }
}

