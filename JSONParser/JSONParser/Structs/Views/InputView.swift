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
        
        case aboutJSON  =
        """
        분석할 JSON 데이터를 입력하세요.\n공백과 ','의 양식을 지켜주세요.
        ex) [ 10, \"Hi, JK\", 4, \"314\", 99, \"Bye, crong\", false ]
        ex) { \"name\" : \"부엉이\" , \"age\" : 27 }
        ex) [ { \"name\" : \"JK\", \"LV\" : 5, \"married\" : true }, { \"name\" : \"crong\", \"LV\" : 4, \"married\" : false } ]
        
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

