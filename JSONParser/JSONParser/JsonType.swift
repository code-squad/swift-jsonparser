//
//  UsableType.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 13..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol JsonType {
    mutating func convertData()
    func checkAvailable() -> Bool
}

protocol JsonCollection {
    func numberByType() -> NumberByType
    func type() -> String
}
