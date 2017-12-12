//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

do {
    let jsonData = try InputView.readValues(ProcessInfo.processInfo.arguments)
    try OutputView.printJSONData(in: jsonData, arguments: ProcessInfo.processInfo.arguments)
} catch let error as JSONError {
    print(error.rawValue)
}

