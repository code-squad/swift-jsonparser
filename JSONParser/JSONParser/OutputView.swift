//
//  Check.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static private func JSONForm(_ jsonData:PrintAble) -> String {
        return "\(jsonData.printForm())"
    }
    
    static func saveJSONData(jsonData:JsonType, fileName:String) {
        let fileManager = FileManager()
        let desktop = fileManager.urls(for: .desktopDirectory, in: .userDomainMask).first!
        let path = desktop.appendingPathComponent(fileName)
        var text = ""
        
        guard let collectionData = jsonData as? JsonCollection else {return}
        let numberOfData = self.numberOfData(collectionData.numberByType(),type:collectionData.type())
        text.append(numberOfData)
        guard let printableData = jsonData as? PrintAble else {return}
        text.append(JSONForm(printableData))
        
        try? text.write(to: path, atomically: false, encoding: .utf8)
    }
    
    static private func numberOfData(_ number:NumberByType, type:TypeInfo) -> String {
        guard number.numberOfAll() > 0 else {return "데이터가 없습니다."}
        var outputInfo = ""
        outputInfo.append("총 \(number.numberOfAll())개의 \(type.rawValue) 데이터 중에")
        outputInfo.append(showResult(readInfo(number)))
        outputInfo.append("가 포함되어 있습니다.\n")
        return outputInfo
    }
    
    static private func readInfo(_ number:NumberByType) -> [String] {
        var outputArray = [String]()
        if number.numberOfString() > 0 {
            outputArray.append(" 문자열 \(number.numberOfString())개")
        }
        if number.numberOfNumber() > 0 {
            outputArray.append(" 숫자 \(number.numberOfNumber())개")
        }
        if number.numberOfBool() > 0 {
            outputArray.append(" 부울 \(number.numberOfBool())개")
        }
        if number.numberOfObject() > 0 {
            outputArray.append(" 객체 \(number.numberOfObject())개")
        }
        if number.numberOfArray() > 0 {
            outputArray.append(" 배열 \(number.numberOfArray())개")
        }
        return outputArray
    }
    
    static private func showResult(_ result:[String]) -> String {
        var outputInfo = ""
        for numberOfData in result {
            outputInfo.append(numberOfData)
            guard numberOfData != result[result.endIndex - 1] else {continue}
            outputInfo.append(",")
        }
        return outputInfo
    }
}
