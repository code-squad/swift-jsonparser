//
//  DataTypeCriterion.swift
//  JSONParser
//
//  Created by 이희찬 on 09/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct DataTypeCriterion {
    let String = CharacterSet(charactersIn: "\"")
    let Int = CharacterSet.decimalDigits
    let Bool = (true:"true", false:"false")
}
