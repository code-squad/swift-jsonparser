//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    let input: String
    let tokens: [Token]
    let jsonContianerValue: JSONContainerValue
    
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
        var lexer = Lexer(input: input)
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
        jsonContianerValue = try parser.parse()
    } catch let error as Parser.Error {
        print(error.localizedDescription)
        return
    } catch {
        print("\(Message.unexpectedError): \(error)")
        return
    }
    
    OutputView.printJSONContainerValue(jsonContianerValue)
}

main()
