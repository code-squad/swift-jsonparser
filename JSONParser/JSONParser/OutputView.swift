//
//  OutputView.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {

    func printResult(jsonResult: String, newFileName: String) {
        if newFileName.count > 0 {
            printOnFile(jsonResult: jsonResult, newFileName: newFileName)
        } else {
            printOnConsole(jsonResult: jsonResult)
        }
    }

    private func printOnConsole(jsonResult: String) {
        print(jsonResult)
    }

    private func printOnFile(jsonResult: String, newFileName: String) {
        let file: String = GuideMessage.baseDirPath.rawValue + newFileName
        if let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            do {
                try jsonResult.write(to: fileURL, atomically: false, encoding: .utf8)
            } catch {
                print(GuideMessage.outputError.rawValue)
            }
        }
    }

}
