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

let string = "[ \"Hello, World!\", 4, false , \"Hello, World!\" ]"
var s = Scanner.init(context: .Value, string: string)

func token() throws {
    print("=================")
    print(try s.next())
    print(s.nestedContexts)
    print("=================")
}

func main() throws {
    while(true){
        readLine()
        try token()
    }
}
try main()
