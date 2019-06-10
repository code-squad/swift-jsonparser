//
//  DataTypeCriterion.swift
//  JSONParser
//
//  Created by 이희찬 on 09/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct DataTypeCriterion {
    let distinguishingString = CharacterSet(charactersIn: "\"")
    let distinguishingInt = CharacterSet.decimalDigits
    let distinguishingBool = (true:"true", false:"false")
}
