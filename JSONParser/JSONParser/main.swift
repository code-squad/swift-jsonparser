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
    let elementType : ElementType!
    let data = input.readJson()
    
    do {
        let beforeData = try parsing.distinctArray(inputdata: data)
        let parsingData = try parsing.parsingData(beforeData: beforeData)
    }catch let error as ErrorMessage{
        print(error.rawValue)
    }catch{
        print(error)
    }
    output.printElements(elementType: elementType, numberOfElements: parsingData.numberOfElements, numberOfString: parsingData.countString, numberOfInt: parsingData.countInt, numberOfBool: parsingData.countBool)
}
