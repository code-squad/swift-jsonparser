//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    var parsedValues: [JSONValue]!
    InputView.printInstruction()
    do {
        let input = try InputView.read()
        let tokens = try Tokenizer.execute(using: input)
        parsedValues = try Parser.parse(tokens)
    } catch let e as JSONError {
        print(e.message)
        return
    } catch {
        print("Other Unexpected Error")
        return
    }
    
    OutputView.printJSONDescription(of: parsedValues)
    
}

main()

