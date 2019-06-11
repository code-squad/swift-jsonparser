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
        
        let typeDescription = arrayValue.typeDescription
        
        let intro = "총 \(totalCount)개의 \(typeDescription) 데이터 중에 "
        let outro = "가 포함되어 있습니다."
        var description = intro
        
        let countDescription = arrayValue.typeCounts
        
        for (type, count) in countDescription {
            description += "\(type) \(count)개 "
        }
        
        description += outro
        
        return description
    }
}
