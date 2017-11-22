//
//  OutputView.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    private let jsonType : JSONType
    
    init(jsonType: JSONType) {
        self.jsonType = jsonType
    }

    enum FileName: String {
        case defaultFileName = "output.json"
    }
    
    func printResult(jsonPainter: JSONPainter) {
        let commandCount: Int = CommandLine.arguments.count
        switch commandCount {
        case 2:
            printOnFile(newFileName: OutputView.FileName.defaultFileName.rawValue, jsonPainter: jsonPainter)
        case 3:
            printOnFile(newFileName: CommandLine.arguments[2], jsonPainter: jsonPainter)
        default:
            printOnConsole(jsonPainter: jsonPainter)
        }
    }

    private func getCountResult() -> String {
        var result : String = "총 \(jsonType.totalCounter)개의 \(jsonType.container) 데이터 중에"
        result += getObjectCounter()
        result += getStringCounter()
        result += getIntCounter()
        result += getBoolCounter()
        result += getArrayCounter()
        result.removeLast()
        result += "가 포함되어 있습니다."
        return result
    }

    private func printOnConsole(jsonPainter: JSONPainter) {
        print(getCountResult())
        print(jsonPainter.jsonPainting)
    }

    private func printOnFile(newFileName: String, jsonPainter: JSONPainter) {
        let basePath: String = "./MyProject/CodeSquad/Masters/Level2/swift-jsonparser/JSONParser/JSONFile/"
        let file: String = basePath + newFileName
        if let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            do {
                let output: String = getCountResult() + "\n" + jsonPainter.jsonPainting
                try output.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {
                print("출력이 정상적으로 이루어지지 않았습니다")
            }
        }
    }
    
    private func getStringCounter() -> String {
        if jsonType.stringCounter > 0 {
            return " 문자열 \(jsonType.stringCounter)개,"
        }
        return ""
    }
    
    private func getIntCounter() -> String {
        if jsonType.intCounter > 0 {
            return " 숫자 \(jsonType.intCounter)개,"
        }
        return ""
    }
    
    private func getBoolCounter() -> String {
        if jsonType.boolCounter > 0 {
            return " 부울 \(jsonType.boolCounter)개,"
        }
        return ""
    }
    
    private func getObjectCounter() -> String {
        if jsonType.objectCounter > 0 {
            return " 객체 \(jsonType.objectCounter)개,"
        }
        return ""
    }
    
    private func getArrayCounter() -> String {
        if jsonType.arrayCounter > 0 {
            return " 배열 \(jsonType.arrayCounter)개,"
        }
        return ""
    }
    
}
