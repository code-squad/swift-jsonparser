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
    
    static func printPretty(of input: JSONContainerType, formatter: Formatter) {
        let prettyJSONString = formatter.prettyJSON(data: input)
        print(prettyJSONString)
    }
    
    static private func printTypesCount(of jsonValue: JSONContainerType) -> String {
        let typeDescription = jsonValue.typeDescription
        let totalCount = jsonValue.totalCount
        let countDescription = jsonValue.typeCounts
        
        let intro = "총 \(totalCount)개의 \(typeDescription) 데이터 중에 "
        let outro = "가 포함되어 있습니다."
        var description = intro
        
        for (type, count) in countDescription {
            description += "\(type) \(count)개 "
        }
        
        description += outro
        return description
    }
}
