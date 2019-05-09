//
//  InputError.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/27/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum InputError: String, Error {
    case dataCountIsZero = "최소 하나의 데이터는 넣어주세요."
    case containsUnsupportedFormats = "지원하지 않는 형식을 포함하고 있습니다."
}
