//
//  InputError.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/27/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum InputError: String, Error {
    case DataCountIsZero = "최소 하나의 데이터는 넣어주세요."
}
