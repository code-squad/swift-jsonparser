//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by BLU on 20/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    
    enum Error: Swift.Error {
        case invalidFormat
        
        var localizedDescription: String {
            switch self {
            case .invalidFormat:
                return "지원하지 않는 형식입니다."
            }
        }
    }
    
    private let pattern: String
    
    init(pattern: String) {
        self.pattern = pattern
    }
    
    func isValid(_ value: String) -> Bool {
        return value.range(of: pattern, options: .regularExpression) != nil
    }
}
