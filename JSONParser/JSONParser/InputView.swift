//
//  InputView.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
     static func readFromConsole() throws -> String {
        print (Message.ofWelcoming.description)
        if let unanalyzedValue = readLine() {
            guard unanalyzedValue == Message.ofEndingProgram.description else { return unanalyzedValue }
        }
        throw Message.ofEndingProgram
    }
    
     static func readFromFile(in filePath: String) throws -> String {
        let directory = FileManager.default.homeDirectoryForCurrentUser
        var textFromFiles: String = ElementOfString.emptyString.rawValue
        do {
            textFromFiles = try String(contentsOf: directory.appendingPathComponent(filePath), encoding: .utf8)
        } catch {
            throw Message.ofFailedProcessingFile
        }
        return textFromFiles
    }
}
