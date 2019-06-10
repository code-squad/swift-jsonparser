//
//  InputView.swift
//  JSONParser
//
//  Created by 이희찬 on 03/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation
struct InputView {
    
    static func readInput(of massage:RequestMassage)throws -> String {
        
        print(massage.rawValue)
        let input = readLine() ?? ""
        try JSONArrayformatValidator(input: input)
        return input
    }
    
    static func JSONArrayformatValidator(input:String)throws {
        guard input.hasPrefix(FormatItem.JSONArrayContainerLeft) && input.hasSuffix(FormatItem.JSONArrayContainerRight) else{
            throw InputError.InputError
        }
    }
    
}
