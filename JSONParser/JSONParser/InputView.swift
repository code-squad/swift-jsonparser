//
//  InputView.swift
//  JSONParser
//
//  Created by 이동영 on 11/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct InputView {
    enum Question : String {
        case aboutJSON = "분석할 JSON 데이터를 입력하세요."
    }
    
    private func ask(_ q:Question) {
        print(q.rawValue)
    }
    
    private func fetchInput() -> String {
        let input = readLine() ?? ""
        
        return input
    }
    
    func run() -> String {
        ask(Question.aboutJSON)
        
        return fetchInput()
    }
    
}
