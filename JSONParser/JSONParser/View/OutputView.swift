//
//  OutputView.swift
//  JSONParser
//
//  Created by CHOMINJI on 22/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    static func printDescription(of input: JSONContainerType) {
        let description = printTypesCount(of: input)
        print(description)
    }
    
    static private func printTypesCount(of arrayValue: JSONContainerType) -> String {
        let totalCount = arrayValue.totalCount
        
        let type = arrayValue.typeDescription
        
        let counts = TypeCounter.count(of: arrayValue)
        let countOfString = arrayValue.countOfString
        let countOfNumber = counts.number
        let countOfBool = counts.bool
        let countOfObject = counts.object
        
        let intro = "총 \(totalCount)개의 \(type) 데이터 중에 "
        let outro = "가 포함되어 있습니다."
        var description = intro
        
        if countOfString > 0 {
            description += "\(String.typeDescription) \(countOfString)개 "
        }
        
        if countOfNumber > 0 {
            description += "\(Number.typeDescription) \(countOfNumber)개 "
        }
        
        if countOfBool > 0 {
            description += "\(Bool.typeDescription) \(countOfBool)개 "
        }
        
        if countOfObject > 0 {
            description += "\(Object.typeDescription) \(countOfObject)개 "
        }
        
        description += outro
        
        return description
    }
}
