//
//  ExtensionArray.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 13..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension Array {
    func numberByType() -> NumberByType {
        var numberOfStirng = 0
        var numberOfNumber = 0
        var numberOfBool = 0
        var numberOfObject = 0
        
        for data in self {
            numberOfStirng += data is JsonString ? 1 : 0
            numberOfNumber += data is JsonNumber ? 1 : 0
            numberOfBool += data is JsonBool ? 1 : 0
            numberOfObject += data is JsonObject ? 1 : 0
        }
        return NumberByType.init(string: numberOfStirng,
                                 number: numberOfNumber,
                                 bool: numberOfBool,
                                 object: numberOfObject)
    }
}
