//
//  OutputView.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation
struct OutputView {
   
     static func makeConsoleResult (_ analyzedValue: JSONDataCommon & JSONType) {
        let countedValue =  CountingJSONData.makeCountedTypeInstance(JSONType: analyzedValue)
        let result = printCountedResult(countedValue) + JSONPrintingMaker.makeNewLine() + printJsonDataType(analyzedValue)
        print(result)
    }
    
    static func writeOutputFile(jsonTypeData: JSONDataCommon & JSONType, outputFile: String, toPath : URL) -> Bool {
        let jsonType = JSONPrintingMaker.makeJSONTypeforPrinting(JSONType: jsonTypeData)
        do {
            try jsonType.write(to: toPath.appendingPathComponent(outputFile) , atomically: false, encoding: .utf8)
            print(Message.ofSuccessProcessingFile)
            return true
        } catch {
            print (Message.ofFailedProcessingFile)
            return false
        }
    }
    
    private static func printCountedResult (_ countedValue: JSONData) -> String {
        return countedValue.type.printResultOfConting(countedValue: countedValue)
    }
    
    private static func printJsonDataType(_ jsonDataType: JSONDataCommon) -> String {
        return JSONPrintingMaker.makeJSONTypeforPrinting(JSONType: jsonDataType)
    }
    
}
