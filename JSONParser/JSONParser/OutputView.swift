//
//  OutputView.swift
//  JSONParser
//
//  Created by BLU on 2019. 5. 29..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    static func printPrettyJSON(_ jsonValue: JSONValue) {
        var writer = Writer { str in
            print(str, terminator: "")
        }
        writer.serializeJSON(jsonValue)
        print("\n", terminator: "")
    }
    
    static func printJSONValue(_ jsonValue: JSONValue) {
        if let jsonContainerValue = jsonValue as? JSONValue & TypeCountable {
            printJSONContainerValue(jsonContainerValue)
        }
    }
    
    private static func printJSONContainerValue(_ jsonContainerValue: JSONValue & TypeCountable) {
        print(jsonContainerValue.typeDescription)
    }
}
