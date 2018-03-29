//
//  InputView.swift
//  JSONParser
//
//  Created by rhino Q on 2018. 3. 29..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

enum InputViewError:Error{
    case invalidValue
}

extension InputViewError:LocalizedError {
    public var errorDescription:String? {
        switch self {
        case .invalidValue:
            return "유효하지 않은 값입니다."
        }
    }
}

struct InputView {
    
    static func readInput(question:String) throws -> String {
        print(question)
        
        guard let rawInput = readLine(), !rawInput.isEmpty else {
            throw InputViewError.invalidValue
        }
        
        return rawInput
    }
    
}
