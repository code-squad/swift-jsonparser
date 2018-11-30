//
//  UsableType.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 13..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol JsonType {
    func type() -> TypeInfo
    func JSONForm() -> String
}

protocol JsonCollection: JsonType {
    func numberByType() -> NumberByType
}

protocol PrintAble {
    func printForm() -> String
}

protocol ObjectKey {
    func key() -> String
}
