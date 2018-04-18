//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    
    guard let input = InputView.readInput(Question.askJSONData), !input.isEmpty else {
        return
    }
    
    do {
        let lexer: Lexer = Lexer(input: input)
        let tokens = try lexer.lex()
        let parser: Parser = Parser(tokens: tokens)
        let jsonData: Parsable = try parser.parse()
        print(jsonData)
        
    } catch Lexer.Error.invalidCharacter(let character) {
        print("Input contained an invalid character: \(character)")
    } catch Lexer.Error.invalidBooleanCharacter {
        print("Boolean input was wrong!")
    } catch Parser.Error.unexpectedEndOfInput {
        print("Unexpected end of input")
    } catch Parser.Error.invalidToken(let token) {
        print("Invalid token : \(token)")
    } catch {
        print("메인에러")
    }
}

main()
