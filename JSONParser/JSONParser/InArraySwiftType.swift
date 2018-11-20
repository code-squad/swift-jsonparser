//
//  SwiftType.swift
//  JSONParser
//
//  Created by 윤동민 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension String : InArraySwiftType, InObjectSwiftType {}
extension Bool : InArraySwiftType, InObjectSwiftType {}
extension Int : InArraySwiftType, InObjectSwiftType {}
extension Dictionary : InArraySwiftType, InputMenu {}
extension Array : InputMenu {}

// 배열 안에 들어갈 수 있는 데이터 타입
protocol InArraySwiftType {
    
}
