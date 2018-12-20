//
//  Parser.swift
//  JSONParser
//
//  Created by Elena on 20/12/2018.
//  Copyright © 2018 elena. All rights reserved.
//

import Foundation
//분석

// 총 몇개의 데이터일까를 protocol로 구현
protocol ParseData {
    var dataNumber: Int { get }
    var dataCount: [String] { get }
}
protocol ParseResult {
    var data: [String:Int] { get }
}

extension String {
    func splitByComma() -> [String] {
        return self.split(separator: ",").map({String($0)})
    }
    func removeBothFirstAndLast() -> String {
        return String(self.dropFirst().dropLast())
    }
}

struct Parser {
    
    static func isDivideData(from data: String) -> Bool {
        
        guard ((data.first?.description) == "["), ((data.last?.description) == "]") else {
            return false
        }
        
        let dataJSON: [String] = data.removeBothFirstAndLast().splitByComma()
        
        // Stack에 데이터만 넣고 싶은데 _ 안써주면 초기화가 안된다.
        //Result of 'Stack' initializer is unused
        _ = Stack(dataJSON)
        return true
    }
    
    func parseData() {
        
    }
}
