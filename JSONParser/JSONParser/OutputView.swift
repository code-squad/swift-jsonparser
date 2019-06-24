//
//  OutputView.swift
//  JSONParser
//
//  Created by BLU on 2019. 5. 29..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    static func printJSONValue(_ jsonValue: JSONValue) {
        if let jsonContainerValue = jsonValue as? JSONContainerValue {
            printJSONContainerValue(jsonContainerValue)
        }
        var writer = Writer { str in
            print(str ?? "", terminator: "")
        }
        writer.serializeJSON(jsonValue)
    }
    
    private static func printJSONContainerValue(_ jsonContainerValue: JSONContainerValue) {
        print(jsonContainerValue.containerDescription)
    }
}
