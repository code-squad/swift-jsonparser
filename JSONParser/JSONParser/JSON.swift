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
    
    // JSON 타입의 배열
    private let dataSetOfJSON : [Any] 
    
    // 생성자
    init(dataSetOfJSON : [Any]){
        self.dataSetOfJSON = dataSetOfJSON
    }
    
    // 데이터를 리턴한다
    func getDataOfJSON() -> [Any] {
        return dataSetOfJSON
    }
}
