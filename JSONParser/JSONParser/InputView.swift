//
//  InputView.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct InputView {
    static func readEnter(ment:String) -> (String,URL?) {
        print(ment)
        return (readLine() ?? "", nil)
    }
    
    static func readContent(readFileName:String, saveFileName:String) -> (String,URL?) {
        let fileManager = FileManager()
        guard let desktop = fileManager.urls(for: .desktopDirectory, in: .userDomainMask).first else {return ("",nil)}
        let path = desktop.appendingPathComponent("\(readFileName)")
        let json = try? String(contentsOf: path, encoding: .utf8)

        return (json ?? "", desktop.appendingPathComponent("\(saveFileName)"))
    }
}
