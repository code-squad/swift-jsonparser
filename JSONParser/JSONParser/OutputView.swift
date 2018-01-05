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
        if argument.count <= 1 {
            print(makeConsolResult(inputString))
        } else if argument.count >= 2 {
            let file = try argument.makeFileIOPath()
            let jsonType = JsonPrintingMaker.makeJsonTypeforPrinting(jsonType: inputString)
            try makeOutputFile(jsonType, file.1)
            throw Message.ofEndingProgram

        } else {
            throw Message.ofFailedProcessingFile
        }
    }
    
    private static func makeConsolResult (_ analyzedValue: JsonDataCommon & JSONType) {
        let countedValue =  CountingJsonData.makeCountedTypeInstance(jsonType: analyzedValue)
        print(printCountedResult(countedValue))
        print(printJsonDataType(analyzedValue))
    }
    
    private static func makeOutputFile(_ prettyJSONData: String, _ filePath: String) throws {
        let dir = FileManager.default.homeDirectoryForCurrentUser
        do {
            try prettyJSONData.write(to: dir.appendingPathComponent(filePath), atomically: false, encoding: .utf8)
            print(Message.ofSuccessProcessingFile.description)
        } catch {
            throw Message.ofFailedProcessingFile
        }
    }
    
    private static func printCountedResult (_ countedValue: JsonData) {
        if countedValue.type == JsonData.CountingType.object {
            print ("총 \(countedValue.total)개의 객체중 숫자 \(countedValue.ofNumericValue)개, 불값 \(countedValue.ofBooleanValue)개, 문자열 \(countedValue.ofStringValue)개, 배열 \(countedValue.ofArray)개가 있습니다.")
        } else if countedValue.type == JsonData.CountingType.array {
            print ("총 \(countedValue.total)개의 배열 데이터중 객체 \(countedValue.ofObject) 숫자 \(countedValue.ofNumericValue)개, 불값 \(countedValue.ofBooleanValue)개, 문자열 \(countedValue.ofStringValue)개, 배열 \(countedValue.ofArray)개가 있습니다.")
        }
    }
    
    private static func printJsonDataType(_ jsonDataType: JsonDataCommon)  {
        print(JsonPrintingMaker.makeJsonTypeforPrinting(jsonType: jsonDataType))
    }
    
}
