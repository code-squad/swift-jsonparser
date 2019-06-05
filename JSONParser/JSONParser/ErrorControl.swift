//
//  ErrorControl.swift
//  JSONParser
//
//  Created by JieunKim on 29/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum JSONError: Error, CustomStringConvertible {
    case wrongValue
    
    var description: String {
        switch self {
        case .wrongValue:
            return "입력값이 유효하지 않습니다."
        }
    }
}
