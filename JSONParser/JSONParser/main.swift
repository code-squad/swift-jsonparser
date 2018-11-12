//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

struct Main {

    private static func decideProgram() -> JSONParserExecutable {
        if CommandLineReader.hasArgument(atIndex: .inputFile) {
            return JSONFileParser()
        }
        return JSONLineParser()
    }
    
    static func run() {
        let jsonParserProgram = decideProgram()
        guard let jsonString = jsonParserProgram.read() else { return }
        guard let jsonDataForm = JSONParser.parse(jsonString) else { return }
        jsonParserProgram.makeResult(of: jsonDataForm)
    }

}

Main.run()
