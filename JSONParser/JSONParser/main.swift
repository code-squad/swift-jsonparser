//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main(){
    do {
        var jsonTokenizer = JSONTokenizer()
        let input = try InputView.ask(for: .request)
        let tokenizedInput = try jsonTokenizer.tokenize(data: input)
        let analyzedInput = try JSONAnalyzer.analyze(data: tokenizedInput)
        let parsedInput = try JSONParser.parseArray(data: analyzedInput)
        try OutputView.printDescription(input: parsedInput)
    } catch let error as JSONError {
        print(error)
    } catch {
        print(error)
    }
}

main()
