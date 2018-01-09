//
//  OutputView.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation
struct OutputView {
    static func printOut (_ inputString: JsonDataCommon & JSONType, _ argument: [String]) throws {
        if argument.count < 2 {
            print(makeConsolResult(inputString))
        } else if argument.count >= 2 {
            let jsonFile = try argument.makeFileIOPath()
            let jsonType = JsonPrintingMaker.makeJsonTypeforPrinting(jsonType: inputString)
            try writeOutputFile(jsonType, jsonFile.1)
            throw Message.ofEndingProgram
    
        } else {
            throw Message.ofFailedProcessingFile
        }
    }
    
    private static func makeConsolResult (_ analyzedValue: JsonDataCommon & JSONType) -> String {
        let countedValue =  CountingJsonData.makeCountedTypeInstance(jsonType: analyzedValue)
        let result = printCountedResult(countedValue) + JsonPrintingMaker.makeNewLine() + printJsonDataType(analyzedValue)
        return result
    }
    
    private static func writeOutputFile(_ jsonTypeData: String, _ unAnaluzedJsonFile: String) throws {
        let outputUrl = URL(fileURLWithPath: unAnaluzedJsonFile)
        do {
            try jsonTypeData.write(to: outputUrl, atomically: false, encoding: .utf8)
            print(Message.ofSuccessProcessingFile.description)
        } catch {
            throw Message.ofFailedProcessingFile
        }
    }
    
    private static func printCountedResult (_ countedValue: JsonData) -> String {
        if countedValue.type == JsonData.CountingType.object {
            return ("총 \(countedValue.total)개의 객체중 숫자 \(countedValue.ofNumericValue)개, 불값 \(countedValue.ofBooleanValue)개, 문자열 \(countedValue.ofStringValue)개, 배열 \(countedValue.ofArray)개가 있습니다.")
        } else {
            return ("총 \(countedValue.total)개의 배열 데이터중 객체 \(countedValue.ofObject) 숫자 \(countedValue.ofNumericValue)개, 불값 \(countedValue.ofBooleanValue)개, 문자열 \(countedValue.ofStringValue)개, 배열 \(countedValue.ofArray)개가 있습니다.")
        }
    }
    
    private static func printJsonDataType(_ jsonDataType: JsonDataCommon) -> String {
        return JsonPrintingMaker.makeJsonTypeforPrinting(jsonType: jsonDataType)
    }
    
}
