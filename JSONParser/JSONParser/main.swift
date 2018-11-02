//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    let input = InputView.readInput()
    let extractedData = input.extractData()
    let extractedSwiftData = Sorter.sortByTypeIntoArray(extractedData)
    OutputView.showNumberOfData(extractedSwiftData)
}

main()
