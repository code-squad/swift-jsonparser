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
        let tokens = try jsonTokenizer.tokenize(data: input)
        let jsonDatas = JSONParser.parseDataArray(tokens: tokens)
        try OutputView.printDescription(input: jsonDatas)
    } catch {
        print(error.localizedDescription)
    }
}

main()
