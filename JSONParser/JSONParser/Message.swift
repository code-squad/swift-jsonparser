//
//  Message.swift
//  JSONParser
//
//  Created by BLU on 2019. 6. 5..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

enum Message {
    case unexpectedError
    
    var description: String {
        switch self {
        case .unexpectedError:
            return "예상치 못한 에러가 발생하였습니다."
        }
    }
}
