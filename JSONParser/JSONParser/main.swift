//
//  main.swift
//  JSONParser
//
//  Created by 심 승민 on 11/06/2017.
//  Copyright © 2017 심 승민. All rights reserved.
//

import Foundation

func main() {
    do {
        while let userInput = try InputView.askFor(message: "분석할 JSON 데이터를 입력하세요: ") {
            let jsonData = try JSONParser.parse(from: userInput)
            OutputView.printDataReport(of: jsonData)
        }
    }catch {
        print(error.localizedDescription)
    }
}

main()
