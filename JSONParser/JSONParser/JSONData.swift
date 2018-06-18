//
//  JSONData.swift
//  JSONParser
//
//  Created by Yoda Codd on 2018. 5. 25..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

/// JSON 데이터들이 준수하게 될 프로토콜 선언
protocol JSONCount {
    // 배열인지 객체인지 표시하는 문자열
    var type : String { get }
    
    // JSONData 를 저장하는 변수
    var dataSetOfJSON : JSONData { get }
}

/// JSON 에서 사용할 데이터 타입들을 선언
enum JSONData {
    // 가능한 타입들
    case number(Int)
    case boolean(Bool)
    case letter(String)
    case object([String:JSONData])
    case array([JSONData])
    
}

/// JSON 배열타입 데이터
class JSONArray : JSONCount {
    // 배열임을 표시한다
    var type = "배열"
    
    // 데이터를 배열로 담는다
    let dataSetOfJSON : JSONData
    
    // 생성자
    init(dataSetOfJSON : [JSONData]){
        self.dataSetOfJSON = .array(dataSetOfJSON)
    }
}

/// JSON Object 타입
class JSONObject : JSONCount {
    // 객체임을 표시한다
    var type = "객체"
    
    // 데이터를 딕셔너리로 담는다
    let dataSetOfJSON : JSONData
    
    // 생성자
    init(dataSetOfJSON : [String : JSONData]){
        self.dataSetOfJSON = .object(dataSetOfJSON)
    }
}

