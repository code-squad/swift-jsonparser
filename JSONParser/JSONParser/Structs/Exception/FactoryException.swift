//
//  FactoryException.swift
//  JSONParser
//
//  Created by 이동영 on 23/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum FactoryException: Exception {
    case failure
    
    var description: String {
        switch self {
        case .failure:
            return "생성 실패"
        }
    }
}
