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
        let jsonValues = try parser.parse()
        OutputView.printJSONValues(jsonValues)
    } catch let error as InputView.Error {
        print(error.localizedDescription)
    } catch let error as Lexer.Error {
        print(error.localizedDescription)
    } catch let error as Parser.Error {
        print(error.localizedDescription)
    } catch {
        print("예상치 못한 에러 발생: \(error))"
    }
}

main()
