//
//  InputView.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct InputView {
    static func readInput(arguments:[String]) -> (String,URL?) {
        if arguments.count == 1 {
            return readEnter(ment: "분석할 JSON 데이터를 입력하세요.")
        }
        if arguments.count == 2 {
            return readContent(readFileName: arguments[1], saveFileName: "output.json")
        }
        return readContent(readFileName: arguments[1], saveFileName: arguments[2])
    }
    
     static private func readEnter(ment:String) -> (String,URL?) {
        print(ment)
        return (readLine() ?? "", nil)
    }
    
    static private func readContent(readFileName:String, saveFileName:String) -> (String,URL?) {
        let fileManager = FileManager()
        guard let desktop = fileManager.urls(for: .desktopDirectory, in: .userDomainMask).first else {return ("",nil)}
        let path = desktop.appendingPathComponent("\(readFileName)")
        let json = try? String(contentsOf: path, encoding: .utf8)

        return (json ?? "", desktop.appendingPathComponent("\(saveFileName)"))
    }
}
