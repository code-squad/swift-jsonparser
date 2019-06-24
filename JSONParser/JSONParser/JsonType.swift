//
//  JsonType.swift
//  JSONParser
//
//  Created by JH on 08/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JsonType {
    var typeName: String { get }
    
    var countInfo: [String: Int] { get }
    
    var count: Int { get }
}

//기본구현함
extension JsonType {
    var countInfo: [String : Int] {
        return [typeName: 1]
    }
    var count: Int {
        return 1
    }
}



extension Double: JsonType {
    var typeName: String {
        return "숫자"
    }
}

extension String: JsonType {
    var typeName: String {
        return "문자열"
    }
    var count: Int {
        return 1
    }
}


extension Bool: JsonType {
    var typeName: String {
        return "부울"
    }
}

extension Array: JsonType where Element == JsonType {
    var typeName: String {
        return "배열"
    }
    //배열은 element갯수가 1개이상일 수 있기 때문에 따로 정의해줌.
    var countInfo: [String : Int] {
        //typeName별로 그룹화해줌
        let byName = Dictionary(grouping: self, by: { $0.typeName })
        //그룹화된 갯수를 반환함
        return byName.compactMapValues({ $0.count })
    }
}



