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
        let input = try InputView.ask(for: .request)
        var jsonTokenizer =  JSONTokenizer.init()
        let tokens = try jsonTokenizer.tokenize(data: input)
        var parser = JSONParser(tokens: tokens)
        let jsonDatas = try parser.parse()
        try OutputView.printOut(jsonDatas)
    } catch {
        print(error.localizedDescription)
    }
}

main()



