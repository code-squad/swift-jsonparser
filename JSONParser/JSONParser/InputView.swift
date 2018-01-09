//
//  InputView.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
     static func readFromConsole() -> String {
     print (Message.ofWelcoming)
        if let unanalyzedValue = readLine() {
            guard unanalyzedValue == Message.ofEndingProgram.description else { return unanalyzedValue }
        }
        return Message.ofEndingProgram.description
    }
    
    static func readFromFile(in filePath: String, url: URL) throws -> String {
        var textFromFiles: String = ElementOfString.emptyString.rawValue
        do {
            textFromFiles = try String(contentsOf: url.appendingPathComponent(filePath), encoding: .utf8)
        } catch {
            throw Message.ofFailedProcessingFile
        }
        return textFromFiles
    }
    
    static func makeInOutFile() -> (String, String)? {
        let elements = CommandLine.arguments
        let inputFile: String
        let outputFile: String
        switch elements.count {
        case 2:
            inputFile = elements[1]
            outputFile = Message.ofDefaultJSONFileName.description
            return (input: inputFile, output: outputFile)
        case 3:
            inputFile = elements[1]
            outputFile = elements[2]
            return (input: inputFile, output: outputFile)
        default:
            print (Message.ofFailedProcessingFile)
            return nil
        }
    }
}
