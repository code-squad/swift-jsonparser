//
//  InputView.swift
//  JSONParser
//
//  Created by 이희찬 on 03/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation
struct InputView {
    
    static func readInput(massage:Massage)throws -> String {
        print(massage.rawValue)
        let input = readLine() ?? ""
        return input
    }

}

enum Massage:String {
    case requestJSON = "분석할 JSON 데이터를 입력하세요."
}
