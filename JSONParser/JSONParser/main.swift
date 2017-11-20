//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

var inputView = InputView()
let jsonValue = inputView.readInput()

var jsonScanner = JsonScanner()
jsonScanner.scanOfJsonValue(jsonValue: jsonValue)
