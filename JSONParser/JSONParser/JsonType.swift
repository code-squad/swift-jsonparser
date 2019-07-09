//
//  JsonType.swift
//  JSONParser
//
//  Created by JH on 08/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JsonType: Serializable, Countable {
    var typeName: String { get }
}

protocol Countable {
    var countInfo: [String: Int] { get }
}

//Countable를 채택하는 객체가 JsonType일때만 기본구현함
extension Countable where Self: JsonType {
    var countInfo: [String: Int] {
        return [typeName: 1]
    }
}

extension Double: JsonType {
    var typeName: String {
        return "숫자"
    }
}

extension String: JsonType {
    func serialized() -> String {
        return "\"\(self)\""
    }
    
    var typeName: String {
        return "문자열"
    }
}


extension Bool: JsonType {
    var typeName: String {
        return "부울"
    }
}

extension Array: Countable where Element == JsonType {
    var countInfo: [String : Int] {
        //typeName별로 그룹화해줌
        let byName = Dictionary(grouping: self, by: { $0.typeName })
        //그룹화된 갯수를 반환함
        return byName.compactMapValues({ $0.count })
    }
}

extension Array: JsonType where Element == JsonType {
    var typeName: String {
        return "배열"
    }
    
    var countInfo: [String : Int] {
        
        let values = self.map { $0.value }
        
        //typeName별로 그룹화해줌
        let byName = Dictionary<String, [JsonType]>(grouping: values) { $0.typeName }
        //그룹화된 갯수를 반환함
        return byName.compactMapValues({ $0.count })
    }
    
}
