//
//  OutputView.swift
//  JSONParser
//
//  Created by BLU on 2019. 5. 29..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    static func printJSONValues(_ jsonValues: [JSONValue]) {
        let groupedJSONValues = Dictionary(grouping: jsonValues, by: { $0.typeDescription })
        print(groupedJSONValues.description)
    }
}
