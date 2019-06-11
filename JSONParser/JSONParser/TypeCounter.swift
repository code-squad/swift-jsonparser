//
//  TypeCounter.swift
//  JSONParser
//
//  Created by CHOMINJI on 24/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TypeCounter {
    
    static func count(of jsonValues: TypeCountable) -> (string: Int, number: Int, bool: Int, object: Int) {
        let types = jsonValues.types
        
        let countOfString = jsonValues.countOfString
        let countOfNumber = types.countType(of: Number.self)
        let countOfBool = types.countType(of: Bool.self)
        let countOfObject = types.countType(of: Object.self)
        
        let result = (countOfString, countOfNumber, countOfBool, countOfObject)
        return result
    }
}

extension Array {
    func countType<T>(of target: T) -> Int {
        return self.filter { $0 is T }.count
    }
}

