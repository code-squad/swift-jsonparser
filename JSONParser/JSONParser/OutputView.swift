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
        printJSONContainerValue(jsonValue)
    }
    
    static private func printJSONContainerValue(_ jsonValue: JSONValue) {
        if let jsonContainerValue = jsonValue as? JSONContainerValue {
            print(jsonContainerValue.containerDescription)
        }
    }
}
