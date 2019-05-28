//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    while true {
        let input = InputView()
        let output = OutputView()
        var tokenizer = Tokenizer()
        var grammarChecker = GrammerChecker()
        var jsonParser = JsonParser()
        let data = input.readJson()
        do {
            try tokenizer.scannerAndTokenizer(text: data)
            let afterTestData = try grammarChecker.grammarTest(jsonData: tokenizer)
            let parsingData = try jsonParser.parsing(inputData: afterTestData)
            output.printElements(jsonParser: jsonParser, dataMent: parsingData)
            break
        }catch let error as ErrorMessage{
            print(error.rawValue)
        }catch{
            print(error)
        }
    }
}

main()
