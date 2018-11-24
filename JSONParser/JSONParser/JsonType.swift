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
}

protocol JsonCollection: JsonType {
    func numberByType() -> NumberByType
}
