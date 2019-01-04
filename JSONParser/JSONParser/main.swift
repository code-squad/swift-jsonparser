//
//  main.swift
//  JSONParser
//
//  Created by Elena on 20/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation


func main() {
    let userData = InputView.getUserString()
    guard let jsonDataForm: JSONDataForm = Parser.divideData(userData) else {
        OutputView.errorResult()
        return
    }
    OutputView.showResultData(of: jsonDataForm)
}


main()
