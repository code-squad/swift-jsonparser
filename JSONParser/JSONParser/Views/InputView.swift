//
//  InputView.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 13..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    func read() -> String? {
        guard let userRawData = readLine() else {
            return nil
        }
        return userRawData
    }
    
}

extension InputView {
    func readFile(name: String) -> String? {
        let documentsDirectory = FileManager.default.currentDirectoryPath
        let filePath = "/\(name)"
        let fileContent = try? String(contentsOfFile: documentsDirectory + filePath, encoding: String.Encoding.utf8)
        return fileContent
    }
}
