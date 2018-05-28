//
//  JSON.swift
//  JSONParser
//
//  Created by Yoda Codd on 2018. 5. 21..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct JSON {
    // JSON 에서 데이터를 나누는 단위
    static let separater : Character = ","
    // JSON 에서 문자열을 감싸는 단위
    static let letterWrapper : Character = "\""
    // JSON 에서 Bool 타입을 표현하는 문자열의 배열
    static let booleanType = ["false", "true"]
    // JSON 배열의 처음 문자
    static let startOfArrayOfJSON : Character  = "["
    // JSON 배열의 마지막 문자
    static let endOfArrayOfJSON : Character  = "]"
    // JSON 오브젝트의 처음 문자
    static let startOfObjectOfJSON : Character  = "{"
    // JSON 오브젝트의 마지막 문자
    static let endOfObjectOfJSON : Character  = "}"
    // JSON 오브젝트에서 키와 값을 나누는 문자
    static let separaterForObject : Character = ":"
    
    
    // 문자열 배열을 받아서 JSON 데이터형으로 바꿔서 리턴한다
    static func makeJSONData(JSONData : String) -> JSONCount {
        return JSONArray(dataSetOfJSON: <#T##[Any]#>)
    }
}
