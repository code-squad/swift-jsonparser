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
        let location = "/CodeSquad_Napster/iOS Level 2/swift-jsonparser/JSONParser/"
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath = location + name
            let fileContent = try? String(contentsOf: documentsDirectory.appendingPathComponent(filePath), encoding: String.Encoding.utf8)
            return fileContent
        }
        return nil
    }
}
