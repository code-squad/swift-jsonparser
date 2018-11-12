//
//  CommandLineReader.swift
//  JSONParser
//
//  Created by 윤지영 on 12/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct CommandLineReader {
    enum Arguments: Int {
        case projectDirectory = 0, inputFile, outputFile
    }

    static func readArgument(atIndex index: Arguments) -> String? {
        let index = index.rawValue
        let args = CommandLine.arguments
        guard index < args.count else { return nil }
        return args[index]
    }
    
    static func hasArgument(atIndex index: Arguments) -> Bool {
        guard readArgument(atIndex: index) != nil else { return false }
        return true
    }
}
