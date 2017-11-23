//
//  InputView.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {

    func readInput(file: String) throws -> String {
        var inputValue: String = ""
        if file.count > 0 {
            inputValue = try readFromFile(file)
        } else {
            inputValue = readFromConsole()
        }
        return inputValue
    }

    func readFromConsole() -> String {
        return readLine() ?? ""
    }

    private func readFromFile(_ fileName: String) throws -> String {
        var inputValue: String = ""
        let base: String = GuideMessage.baseDirPath.rawValue
        let file: String = base + fileName
        if let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            inputValue = try String(contentsOf: fileURL, encoding: .utf8)
        }
        return inputValue.trimmingCharacters(in: .whitespaces)
    }

}
