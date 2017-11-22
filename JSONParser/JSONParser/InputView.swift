//
//  InputView.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    let grammarChecker: GrammarChecker

    init(grammarChecker: GrammarChecker) {
        self.grammarChecker = grammarChecker
    }

    func readInput() throws -> String {
        let commandCount: Int = CommandLine.arguments.count
        var result: String = ""
        switch commandCount {
        case 2,3:
            result = try readFromFile()
        default:
            result = readFromConsole()
        }
        return result
    }

    func readFromConsole() -> String {
        var inputValue: String = ""
        var isJSONPattern: Bool = false
        while !isJSONPattern {
            print(GuideMessage.inputRequest.rawValue)
            inputValue = readLine() ?? "[]"
            isJSONPattern = grammarChecker.isJSONPattern(target: inputValue)
            if !isJSONPattern {
                print(GuideMessage.notJSONPattern.rawValue)
            }
        }
        return inputValue
    }

    func readFromFile() throws -> String {
        var inputValue: String = ""
        let file: String = GuideMessage.baseDirPath.rawValue + CommandLine.arguments[1]
        if let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            inputValue = try String(contentsOf: fileURL, encoding: .utf8)
            if !grammarChecker.isJSONPattern(target: inputValue) {
                throw GuideMessage.notJSONPattern
            }
        }
        return inputValue.trimmingCharacters(in: .whitespaces)
    }

}
