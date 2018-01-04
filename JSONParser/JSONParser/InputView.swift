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
        let directory = FileManager.default.urls(for: .userDirectory, in: .localDomainMask).first
        let userDirectoryPath = "Jack/proj/swift-jsonparser/JSONParser/JSONFile/"
        let file = userDirectoryPath + fileName
        guard let baseDirectory = directory else { return "" }
        let filePath = baseDirectory.appendingPathComponent(file)
        return try String(contentsOf : filePath, encoding : .utf8)
    }
    
}

