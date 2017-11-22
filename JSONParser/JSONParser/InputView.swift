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

    enum InputError: Error {
        case notJSONPattern
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
            print("분석할 JSON 데이터를 입력하세요.")
            inputValue = readLine() ?? "[]"
            isJSONPattern = grammarChecker.isJSONPattern(target: inputValue)
            if !isJSONPattern {
                print("지원하지 않는 형식을 포함하고 있습니다.")
            }
        }
        return inputValue
    }

    func readFromFile() throws -> String {
        var inputValue: String = ""
        let basePath: String = "./MyProject/CodeSquad/Masters/Level2/swift-jsonparser/JSONParser/JSONFile/"
        let file: String = basePath + CommandLine.arguments[1]
        if let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            inputValue = try String(contentsOf: fileURL, encoding: .utf8)
            if !grammarChecker.isJSONPattern(target: inputValue) {
                throw InputView.InputError.notJSONPattern
            }
        }
        return inputValue.trimmingCharacters(in: .whitespaces)
    }

}
