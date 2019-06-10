//
//  ErrorControl.swift
//  JSONParser
//
//  Created by JieunKim on 29/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum JSONError: String, Error, CustomStringConvertible {
    var description: String { return self.rawValue }
        case wrongValue = "입력값이 유효하지 않습니다."
        case emptyBuffer = "buffer가 비었습니다."
        case notArray = "Array가 아닙니다."
        case unexpectedSeperator = "예상치 못한 ,가 나왔습니다."
}
