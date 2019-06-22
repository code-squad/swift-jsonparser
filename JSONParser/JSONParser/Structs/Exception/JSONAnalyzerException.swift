//
//  JSONAnalyzerException.swift
//  JSONParser
//
//  Created by 이동영 on 23/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation


extension JSONAnalyer {
    enum AnalyerException: Exception {
        case grammerException
        
        var description: String {
            switch self {
            case .grammerException:
                return "지원하지 않는 형식입니다."
            }
        }
    }
}
