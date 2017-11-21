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
var token = jsonScanner.scanOfJsonValue(jsonValue: jsonValue)

//for index in token {
//    print(index.id, index.value)
//}

