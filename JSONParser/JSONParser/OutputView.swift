//
//  OutputView.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 19..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    enum Messages : String {
        case inputMessage = "분석할 JSON데이터를 입력하세요. 종료를 원하시면 q를 입력해주세요."
        case formatError = "지원하는 형식이 아닙니다. 다시 입력해주세요."
        case exitMessage = "종료합니다."
        case fileError = "파일이 생성되지 않았습니다."
        case fileMessege = "파일이 정상적으로 생성되었습니다."
    }
    
    func printMessages(_ message : Messages) {
        print(message.rawValue)
    }
    
    func printCountOfData(_ countVal : MyCount, _ printVal : Bool) {
        var temp = ""
        let countOfData = makeNumberMessage(countVal)
        if countVal.currentData == "dictionary"  {
            temp = "총 \(countVal.objectVal)개의 객체 데이터 중에 \(countOfData)포함되어 있습니다.\n"
            choosePrinting(outputString: temp, printVal)
            return
        }
        let sumOfCount = countVal.boolVal + countVal.numberVal + countVal.boolVal + countVal.objectVal + countVal.arrayVal
        temp = "총 \(sumOfCount)개의 배열 데이터 중에 \(countOfData)포함되어 있습니다.\n"
        choosePrinting(outputString: temp, printVal)
        return
    }
    
    func printShapeOfData(_ userData : Any, _ printVal : Bool) {
        var temp : String = ""
        if userData is ObjectDictionary {
            choosePrinting(outputString: generateShapeOfObject(userData as! [String:Any]) + "}", printVal)
            return
        }
        for oneData in userData as! [Any] {
            if oneData is ObjectDictionary{
                temp += generateShapeOfObject(oneData as! [String:Any])
                temp += "\t},"
                continue
            }
            temp +=  "\n\t\(oneData),"
        }
        choosePrinting(outputString: "[\(temp)\n]", printVal)
        return
    }
    
    func writeFile(resultData : String, _ fileName : String) throws {
        var tempFileName = fileName
        if tempFileName == "" {
            tempFileName = "output.json"
        }
        try resultData.write(toFile: currentDirectory + "/\(tempFileName)" , atomically: false, encoding: .utf8)
        self.printMessages(.fileMessege)
    }
    
    private func choosePrinting (outputString : String,_ printVal : Bool) {
        if printVal {
            print(outputString)
        }
        resultOfData += outputString
    }
    
    private func generateShapeOfObject(_ userData : [String : Any]) -> String {
        var temp : String = ""
        let dataOfdictionary = Array(userData)
        for index in 0..<dataOfdictionary.count {
        temp += "\t\"\(dataOfdictionary[index].key)\" : \(dataOfdictionary[index].value),\n"
        }
        return "{\n\(temp)"
    }
    
    private func makeNumberMessage(_ data : MyCount) -> String {
        var temp = ""
        if data.stringVal != 0 { temp += "문자열 \(data.stringVal)개 "}
        if data.numberVal != 0 { temp += "숫자 \(data.numberVal)개 "}
        if data.boolVal != 0 { temp += "부울 \(data.boolVal)개 "}
        if data.arrayVal != 0 { temp += "배열 \(data.arrayVal)개 "}
        if data.objectVal != 0 && data.currentData == "array" { temp += "객체 \(data.objectVal)개 "}
        return temp
    }
    
}
