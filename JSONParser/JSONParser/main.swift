//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation


var tknr = MyTokenizer()
_ = try tknr.tokenize("[ \"Hello, World!\", 4, false ]")

let string = "[ \"Hi, JK\", 4, false , \"Bye, JK!\" ]"
