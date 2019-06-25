//
//  InputView.swift
//  JSONParser
//
//  Created by 이동영 on 18/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct InputView {
   
    private enum Question: String, CustomStringConvertible {
        var description: String { return self.rawValue }
        case aboutJSON =
        """
        분석할 JSON 데이터를 입력하세요.
        ex)
        { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }
        
        [ { \"name\" : \"master's course\", \"opened\" : true }, [ \"java\", \"javascript\", \"swift\" ] ]
        """
    }
    
    private func ask(_ question: Question) {
        print(question)
    }
    
    private func fetchInput() -> String {
        return readLine() ?? ""
    }
    
    public func run() -> String {
        self.ask(Question.aboutJSON)
        return fetchInput()
    }
}

