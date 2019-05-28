//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    do {
        let input = InputView.readInput()
        
        let tokens = try Tokenizer.tokenize(input: input)
        let parseResult = try Parser.parse(tokens: tokens)
        
        OutputView.printParseResult(result: parseResult)
    } catch let error as TypeError {
        print(error.description)
    } catch let error as TokenizeError {
        print(error.description)
    } catch let error as ParseError{
        print(error.description)
    } catch {
        return
    }
}

main()
