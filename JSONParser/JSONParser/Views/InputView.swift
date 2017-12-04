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
        let location = "/Users/Mrlee/Documents/CodeSquad_Napster/iOS Level 2/swift-jsonparser/JSONParser/"
        let fileContent = try? String(contentsOfFile: location + name, encoding: String.Encoding.utf8)
        return fileContent
    }
}
