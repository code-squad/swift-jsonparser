//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

do {
    OutputView.printResult(in: try InputView.readValue())
} catch let error as InputView.Errors {
    print(error.rawValue)
} catch let error2 as OutputView.Errors {
    print(error2.rawValue)
}

