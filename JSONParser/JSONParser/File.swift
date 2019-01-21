//
//  File.swift
//  JSONParser
//
//  Created by Elena on 18/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JSONParserReadWrite {
    func readUserString() -> String?
    func writeResult(_: JSONDataForm)
}

struct CommandLineRead {
    enum Arguments: Int {
        case projectAddress = 0, inputFile, outputFile
    }
    
    static func readArgument(_ index: Arguments) -> String? {
        let index = index.rawValue
        let commandArgs = CommandLine.arguments
        guard index < commandArgs.count else { return nil }
        return commandArgs[index]
    }
    
    static func selectArgument(_ index: Arguments) -> Bool {
        guard readArgument(index) != nil else { return false }
        return true
    }
}

struct File {
    
    static func getURL(_ file: String? = nil) -> URL? {
        let fileURL = FileManager.default.urls(for: .desktopDirectory,in: .userDomainMask)[0]
        guard let file = file else { return fileURL }
        let fileURLAppendingPath = fileURL.appendingPathComponent(file)
        return fileURLAppendingPath
    }
    
    static func readData(_ file: String) -> String? {
        guard let fileURL = getURL(file) else { return nil }
        guard let data = try? String(contentsOf: fileURL) else { return nil }
        return data
    }
}

struct JSONLineParser: JSONParserReadWrite {
    
    func readUserString() -> String? {
        let jsonString = InputView.getUserString()
        return jsonString
    }
    
    func writeResult(_ jsonDataForm: JSONDataForm) {
        OutputView.showJSONTypeData(jsonDataForm)
    }
    
}

struct JSONFileParser: JSONParserReadWrite {
    private let defaultName = "defaultName.json"
    
    func readUserString() -> String? {
        guard let file = CommandLineRead.readArgument(.inputFile) else { return nil }
        guard let jsonString = File.readData(file) else { return nil }
        return jsonString
    }

    func writeResult(_ jsonDataForm: JSONDataForm) {
        let file = CommandLineRead.readArgument(.outputFile) ?? defaultName
        OutputView.writeShowJSONTypeData(jsonDataForm,file)
    }
    
}


