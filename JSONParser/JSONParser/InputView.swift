//
//  InputView.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct InputView {
    static func readInput() -> (String,String) {
        let arguments = CommandLine.arguments
        let fileManager = FileManager()
        guard let desktop = fileManager.urls(for: .desktopDirectory, in: .userDomainMask).first else {return ("","")}
        let path = desktop.appendingPathComponent("\(arguments[1])")
        let json = try? String(contentsOf: path, encoding: .utf8)
        
        if arguments.count > 2 {
            return (json ?? "", arguments[2])
        }
        return (json ?? "", "output.json")
    }
}
