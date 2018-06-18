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
    
    
    // JSONData 의 분석정보를 담는 클래스
    var jsonInformation : JSONInformation { get }
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

/// 배열과 객체의 분석정보를 가지는 클래스
class JSONInformation {
    // 인트형 개수
    var countOfInt = 0
    // 문자형 개수
    var countOfString = 0
    // Bool형 개수
    var countOfBool = 0
    // 객체형 개수
    var countOfObject = 0
    // 배열형 개수
    var countOfArray = 0
    // 내용을 JSON 스타일로 출력하게될 변수
    var detailOfJSON = ""
}

/// JSON 배열,객체의 수퍼클래스
class JSON {
    // JSONData 의 분석정보를 담는 클래스
    var jsonInformation = JSONInformation()
    
    // 분석정보를 입력받는 함수
    func getInformation(jsonInformation: JSONInformation){
        self.jsonInformation = jsonInformation
    }
}

/// JSON 배열타입 데이터
class JSONArray :  JSON, JSONCount {
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
class JSONObject :  JSON, JSONCount {
    // 객체임을 표시한다
    var type = "객체"
    
    // 데이터를 딕셔너리로 담는다
    let dataSetOfJSON : JSONData
    
    // 생성자
    init(dataSetOfJSON : [String : JSONData]){
        self.dataSetOfJSON = .object(dataSetOfJSON)
    }
}

