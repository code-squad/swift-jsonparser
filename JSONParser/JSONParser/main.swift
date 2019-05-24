//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    var parsedValue: JSONValue!
    InputView.printInstruction()
    do {
        let input = try InputView.read()
        let tokens = try Tokenizer.execute(jsonData: input)
        var jsonParser = Parser(tokens: tokens)
        parsedValue = try jsonParser.parse()
        try OutputView.printJSONDescription(of: parsedValue)
    } catch let e as JSONError {
        print(e.message)
        return
    } catch {
        print("Other Unexpected Error")
        return
    }
}

main()

