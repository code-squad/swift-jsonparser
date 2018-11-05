//
//  InputView.swift
//  JSONParser
//
//  Created by 윤지영 on 18/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct InputView {
    static private let guideMessage = "분석할 JSON 데이터를 입력하세요."
    static private let inputFileDirPath = "/Users/yxxjy/DevNote/swift-jsonparser/"
    
    enum Arguments: Int {
        case projectDirectory = 0, inputFile, outputFile
    }
    
    static func readArgument(atIndex index: Arguments) -> String? {
        let index = index.rawValue
        let args = CommandLine.arguments
        guard index < args.count else { return nil }
        return args[index]
    }

    static func readContents(from file: String) -> String? {
        guard let data = FileManager.default.contents(atPath: "\(inputFileDirPath)\(file)") else { return nil }
        return String(decoding: data, as: UTF8.self)
    }
    
    static func readInput() -> String {
        print(guideMessage)
        guard let input: String = readLine() else { return String() }
        return input
    }
}
