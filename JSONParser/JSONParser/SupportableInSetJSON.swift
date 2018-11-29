//
//  SwiftType.swift
//  JSONParser
//
//  Created by 윤동민 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

// 배열 안에 들어갈 수 있는 데이터 타입
protocol SupportableInSetJSON {
    // 개별요소로 올 경우 문자열 화
    func createValueJSONString(tab : String) -> String
}

extension String : SupportableInSetJSON {
    func createValueJSONString(tab: String) -> String {
        return "\(tab)\(self)"
    }
}

extension Bool : SupportableInSetJSON  {
    func createValueJSONString(tab: String) -> String {
        return "\(tab)\(self)"
    }
}

extension Int : SupportableInSetJSON {
    func createValueJSONString(tab: String) -> String {
        return "\(tab)\(self)"
    }
}
