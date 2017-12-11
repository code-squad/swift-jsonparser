//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

do {
    try OutputView.printJSONData(in: try InputView.readValues())
} catch let error as JSONError {
    print(error.rawValue)
}

