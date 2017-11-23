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

    func readInput(isError: Bool) throws -> String {
        var inputValue: String = ""
        let commandCount: Int = CommandLine.arguments.count
        switch commandCount {
        case 2,3:
            inputValue = try readFromFile(isError: isError)
        default:
            inputValue = try readFromConsole()
        }
        return inputValue
    }

    private func readFromConsole() throws -> String {
        var inputValue: String = ""
        inputValue = readLine() ?? "[]"
        try checkJSONPattern(inputValue: inputValue)
        return inputValue
    }

    private func readFromFile(isError: Bool) throws -> String {
        var inputValue: String = ""
        let base: String = GuideMessage.baseDirPath.rawValue
        var file: String = base
        if isError {
            print("파일명을 확인해서 다시 입력해주세요.")
            file += readLine() ?? "[]"
        } else {
            file += CommandLine.arguments[1]
        }
        if let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            inputValue = try String(contentsOf: fileURL, encoding: .utf8)
            try checkJSONPattern(inputValue: inputValue)
        }
        return inputValue.trimmingCharacters(in: .whitespaces)
    }

    private func checkJSONPattern(inputValue: String) throws {
        if !grammarChecker.isJSONPattern(target: inputValue) {
            throw GuideMessage.notJSONPattern
        }
    }

}
