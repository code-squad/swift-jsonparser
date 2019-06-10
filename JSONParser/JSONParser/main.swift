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
        let input = try InputView.readJSONData()
        var lexer = Lexer(input: input)
        let tokens = try lexer.tokenize()
        var parser = Parser(tokens: tokens)
        let jsonContainerValue = try parser.parse()
        OutputView.printJSONContainerValue(jsonContainerValue)
    } catch let error as InputView.Error {
        print(error.localizedDescription)
    } catch let error as Lexer.Error {
        print(error.localizedDescription)
    } catch let error as Parser.Error {
        print(error.localizedDescription)
    } catch {
        print("\(Message.unexpectedError): \(error)")
    }
}

main()
