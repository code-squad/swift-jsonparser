//
//  main.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/26/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

func main () {
    var inputView = InputView()
    let outputView = OutputView()
    var json = [JsonType]()
    while true {
        inputView.readInput()
        do {
            try GrammarChecker.checkJsonGrammar(inputView.valueEntered)
            json = Converter.stringToJson(inputView.valueEntered)
            break
        }
        catch let error as InputError { print(error.rawValue) }
        catch { print(error) }
    }
    
    let message = MessageMaker.makeMessage(json)
    outputView.printMessage(message)
}

main()

