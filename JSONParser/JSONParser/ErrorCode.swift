//
//  ErrorCode.swift
//  JSONParser
//
//  Created by hw on 07/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum ErrorCode: Error, CustomStringConvertible{
    var description: String  {
        get{
            switch self{
            case .noInput:
                return  "입력값이 없습니다."
            case .invalidJsonFormat:
                return "유효하지 않은 json 포맷입니다."
            }
            
        }
    }
    
    case noInput
    case invalidJsonFormat
}
