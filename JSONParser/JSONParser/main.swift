//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    let input = InputView()
    let output = OutputView()
    var jsonParser = JsonParser()
    var tokenizer = Tokenizer()
    
    while true {
        let data = input.readJson()
        do {
            try tokenizer.scannerAndTokenizer(text: data)
            let parsingData = try jsonParser.parsing(inputData: tokenizer)
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
