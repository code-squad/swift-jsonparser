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
     return readLine() ?? ""
    }
    
    static func readFromFile(file InputFile: String, fromPath: URL) -> String {
        var textFromFiles: String = ElementOfString.emptyString.rawValue
        do {
            textFromFiles = try String(contentsOf: fromPath.appendingPathComponent(InputFile), encoding: .utf8)
        } catch {
            print (Message.ofFailedProcessingFile)
        }
        return textFromFiles
    }
    
    static func makeInOutFile() -> (inputFile: String, outputFile: String)? {
        let elements = CommandLine.arguments
        let inputFile: String
        let outputFile: String
        switch elements.count {
        case 2:
            inputFile = elements[1]
            outputFile = Message.ofDefaultJSONFileName.description
            return (inputFile: inputFile, outputFile: outputFile)
        case 3:
            inputFile = elements[1]
            outputFile = elements[2]
            return (inputFile: inputFile, outputFile: outputFile)
        default:
            print (Message.ofFailedProcessingFile)
            return nil
        }
    }
}
