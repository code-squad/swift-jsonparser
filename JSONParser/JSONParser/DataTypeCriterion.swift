//
//  DataTypeCriterion.swift
//  JSONParser
//
//  Created by 이희찬 on 09/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct DataTypeCriterion {
    static let String = CharacterSet(charactersIn: "\"")
    static let Int = CharacterSet.decimalDigits
    static let Bool = (true:"true", false:"false")
}
