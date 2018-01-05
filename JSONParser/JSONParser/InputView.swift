//
//  InputView.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 19..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    
    func readConsoleInput() -> String {
        return readLine() ?? ""
    }
    
    func readFile(_ fileName : String, userPath : String) throws -> String {
        return try String(contentsOfFile :  userPath + "/\(fileName)", encoding : .utf8)
    }
    
}

