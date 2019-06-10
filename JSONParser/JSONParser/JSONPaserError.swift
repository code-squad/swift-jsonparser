//
//  Erroe.swift
//  JSONParser
//
//  Created by 이희찬 on 09/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JSONError: Error {
    var message: String { get }
}

enum ConvertError: String, JSONError {
    case canNotCovertData = "변환할 수 없는 데이터가 포함되어 있습니다."
    
    var message: String {
        return self.rawValue
    }
}
