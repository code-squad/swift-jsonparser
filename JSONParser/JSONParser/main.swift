//
//  main.swift
//  JSONParser
//
//  Created by Elena on 20/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

func selectMode() -> JSONParserReadWrite {
    if CommandLineRead.selectArgument(.inputFile) {
        return JSONFileParser()
    }
    return JSONLineParser()
}

func main() {
    let jsonFileData = selectMode()
    guard let userData = jsonFileData.readUserString() else { return }
    guard let jsonDataForm = Parser.divideData(userData) else { return }
    jsonFileData.writeResult(jsonDataForm)
}



main()
