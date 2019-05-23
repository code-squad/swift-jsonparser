//
//  InputView.swift
//  JSONParser
//
//  Created by 이동영 on 18/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct InputView {
    private enum Question: String,CustomStringConvertible {
        var description: String { return self.rawValue}
        
        case aboutJSON  = "분석할 JSON 데이터를 입력하세요.\n공백과 ','의 양식을 지켜주세요.\nex) [ 10, \"Hi, JK!\", 4, \"314\", 99, \"Bye, crong!\", false ] "
    }
    
    private func ask(_ Q:Question) {
        print(Q)
    }
    
    private func fetchInput() -> String {
        return readLine() ?? ""
    }
    
    public func run() -> String {
        self.ask(Question.aboutJSON)
        return fetchInput()
    }
    
}

