//
//  JsonParser.swift
//  JSONParser
//
//  Created by jang gukjin on 02/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonParser {
    func distinctArray(inputdata: String?) throws -> String {
        guard let input = inputdata, input.first == "[", input.last == "]" else { throw ErrorMessage.notArray }
        return input
    }
    
    func parsingData(beforeData : String) throws -> (numberOfElements: Int, countString: Int, countInt: Int, countBool: Int ){
        var countString = 0
        var countInt = 0
        var countBool = 0
        var datas = beforeData
        datas.removeFirst()
        datas.removeLast()
        let refinedData = datas.components(separatedBy: ",").filter { $0 != "" }
        for dataElement in refinedData {
            if dataElement.contains("\"") { countString += 1 }
            else if let _ = Int(dataElement) { countInt += 1 }
            else if let _ = Bool(dataElement) { countBool += 1 }
            else { throw ErrorMessage.wrongValue}
        }
        return (refinedData.count, countString, countInt, countBool)
    }
}
