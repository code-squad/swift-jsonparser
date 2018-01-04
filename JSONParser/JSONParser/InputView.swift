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
    
    func readFile(_ fileName : String) throws -> String {
        guard let filePath = currentDirectory else { return "" }
        return try String(contentsOf : filePath.appendingPathComponent("/\(fileName)"), encoding : .utf8)
    }
    
}

