//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func run() {
    let input: String
    let tokens: [Token]
    let jsonValue: JSONValue
    
    do {
        input = try InputView.readJSONData()
    } catch let error as InputView.Error {
        print(error.localizedDescription)
        return
    } catch {
        print("\(Message.unexpectedError): \(error)")
        return
    }
    
    do {
        let reader = Reader(input: input)
        var lexer = Lexer(reader: reader)
        tokens = try lexer.tokenize()
    } catch let error as Lexer.Error {
        print(error.localizedDescription)
        return
    } catch {
        print("\(Message.unexpectedError): \(error)")
        return
    }
    
    do {
        var parser = Parser(tokens: tokens)
        jsonValue = try parser.parseJSONValue()
    } catch let error as Parser.Error {
        print(error.localizedDescription)
        return
    } catch {
        print("\(Message.unexpectedError): \(error)")
        return
    }
    
    OutputView.printJSONValue(jsonValue)
}

run()
