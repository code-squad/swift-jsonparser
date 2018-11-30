//
//  InputView.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct InputView {
    static func readInput(ment:String) -> String {
        print(ment)
        return readLine() ?? ""
    }
    
    static func readFile() -> String {
        let arguments = CommandLine.arguments
        let fileManager = FileManager()
        let desktop = fileManager.urls(for: .desktopDirectory, in: .userDomainMask).first!
        let path = desktop.appendingPathComponent("\(arguments[1])")
        let json = try? String(contentsOf: path, encoding: .utf8)
        
        return json ?? ""
    }
}
