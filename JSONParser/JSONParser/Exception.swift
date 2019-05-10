//
//  Exception.swift
//  JSONParser
//
//  Created by 이동영 on 11/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

typealias ErrorMessage = String

enum Exception: ErrorMessage,Error,CustomStringConvertible{
    var description: String { return self.rawValue }
    
    case wrongFormat = "잘못된 형식입니다."
}
