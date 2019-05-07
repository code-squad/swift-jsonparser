//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    let input = InputView()
    let output = OutputView()
    let parsing = JsonParser()
    let data = input.readJson()
    
    do {
        let jsonData = try parsing.buildArray(inputdata: data)
        output.printElements(jsonData: jsonData)
    }catch let error as ErrorMessage{
        print(error.rawValue)
    }catch{
        print(error)
    }
    
}

main()
