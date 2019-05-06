//
//  TypeInt.swift
//  JSONParser
//
//  Created by jang gukjin on 03/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TypeInt: ElementType {
    func outputMent(number: Int) -> (type: String, value: Int) {
        let type = "숫자 "
        return (type: type, value: number)
    }
}
