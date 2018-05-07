//
//  OutputView.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

protocol JSONPrintable {
    func totalDataCountDescription() -> String
    func countDataDescription() -> String
    func validateJSONData() -> String
    func makeJSONObjectFormat(indent: Int, _ jsonObject: [String:JSONDataValue]) -> String
    func makeJSONArrayFormat(indent: Int, _ jsonArrayData: [JSONDataValue]) -> String
}

struct OutputView {
    enum Error: Swift.Error {
        case writeFailToFile
        case invalidNumberOfArguments
        
        var errorMessage: String {
            switch self {
            case .writeFailToFile:
                return "파일쓰기 실패"
            case .invalidNumberOfArguments:
                return "터미널 실행 인자값 갯수 오류"
            }
        }
    }
    
    static let defaultOutputFileName = "output.json"
    
    static func printNumberOfJSONData(_ jsonData: JSONPrintable) {
        print("\(jsonData.totalDataCountDescription())\(jsonData.countDataDescription())가 포함되어 있습니다.")
    }
    
    static func printJSONData(_ jsonData: JSONPrintable) {
        print(jsonData.validateJSONData())
    }
    
    static func writeJSONData(_ jsonData: JSONPrintable, fileName: String) throws {
        let outputFilePath: String = FileManager.default.currentDirectoryPath.appending("/\(fileName)")
        guard let _ = try? jsonData.validateJSONData().write(toFile: outputFilePath, atomically: true, encoding: .utf8) else {
            throw OutputView.Error.writeFailToFile
        }
    }
}

extension JSONPrintable {
    
    func makeJSONObjectFormat(indent: Int, _ jsonObject: [String:JSONDataValue]) -> String {
        var result: String = "{"
        for (key, jsonDataValue) in jsonObject {
            result += "\n"
            result += String(repeating: "\t", count: indent)
            switch jsonDataValue {
            case .boolean(let value):
                result += "\(key): \(value),"
            case .characters(let value):
                result += "\(key): \"\(value)\","
            case .number(let value):
                result += "\(key): \(value),"
            case .object(let value):
                result += "\(key): "
                result += "\(self.makeJSONObjectFormat(indent: indent + 1, value)),"
            case .array(let value):
                result += "\(key): "
                result += "\(self.makeJSONArrayFormat(indent: indent + 1, value)),"
            }
        }
        result.removeLast()
        result += "\n"
        result += String(repeating: "\t", count: indent - 1)
        result += "}"
        return result
    }
    
    func makeJSONArrayFormat(indent: Int, _ jsonArrayData: [JSONDataValue]) -> String {
        var result = "["
        for jsonData in jsonArrayData {
            switch jsonData {
            case .boolean(let value):
                result += "\(value), "
            case .characters(let value):
                result += "\"\(value)\", "
            case .number(let value):
                result += "\(value), "
            case .array(let value):
                result += "\t\(self.makeJSONArrayFormat(indent: indent + 1, value)), "
            case .object(let value):
                result += "\(self.makeJSONObjectFormat(indent: indent + 1, value)), "
            }
        }
        result.removeLast(2)
        if indent == 1 {
            result += "\n"
        }
        result += "]"
        return result
    }
    
}
