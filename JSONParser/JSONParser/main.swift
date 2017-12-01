//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func ramifyExecuting() {
    let analyzer = JSONAnalyzer()
    if CommandLine.argc == 1 {
        analyzer.make()
    }
    if CommandLine.argc == 2 {
        analyzer.make(inputFile: CommandLine.arguments[1], outputFile: nil)
    }
    if CommandLine.argc == 3 {
        analyzer.make(inputFile: CommandLine.arguments[1], outputFile: CommandLine.arguments[2])
    }
}

ramifyExecuting()
