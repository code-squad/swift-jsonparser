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
    
    // 인트형 개수
    var countOfInt : Int { get }
    // 문자형 개수
    var countOfString : Int { get }
    // Bool형 개수
    var countOfBool : Int { get }
    // 객체형 개수
    var countOfObject : Int { get }
    // 배열형 개수
    var countOfArray : Int { get }
    
    func countType ()
}

/// JSON 에서 사용할 데이터 타입들을 선언
enum JSONData {
    case number(Int)
    case boolean(Bool)
    case letter(String)
    case object([String:JSONData])
    case array([JSONData])
}

/// JSON 카운팅을 위한 구조체
class JSONCounter {
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
    
    /// JSON의 value 를 받아서 카운트
    func countValue(value: JSONData){
        // 각 항목별 체크
        switch value {
        // 인트형일 경우
        case .number(_) : countOfInt += 1
        // 문자형일 경우
        case .letter(_) : countOfString += 1
        // Bool형일 경우
        case .boolean(_) : countOfBool += 1
        // 객체형일 경우
        case .object(_) : countOfObject += 1
        // 배열형의 경우
        case .array(_) : countOfArray += 1
        }
    }
}

/// JSON 배열타입 데이터
class JSONArray : JSONCounter, JSONCount {
    // 배열임을 표시한다
    var type = "배열"
    
    // 데이터를 배열로 담는다
    private let dataSetOfJSON : [JSONData]
    
    // 생성자
    init(dataSetOfJSON : [JSONData]){
        self.dataSetOfJSON = dataSetOfJSON
    }
    
    /// JSON 배열 데이터중 입력받은 자료형 별로 변수에 추가.
    func countType(){
        // JSON 배열을 반복문에 넣는다
        for value in self.dataSetOfJSON {
            // 각 항목별 체크
            countValue(value: value)
        }
    }
}

/// JSON Object 타입
class JSONObject : JSONCounter, JSONCount {
    // 객체임을 표시한다
    var type = "객체"
    
    // 데이터를 딕셔너리로 담는다
    private let dataSetOfJSON : [String : JSONData]
    
    // 생성자
    init(dataSetOfJSON : [String : JSONData]){
        self.dataSetOfJSON = dataSetOfJSON
    }
    
    ///JSON 객체 데이터중 입력받은 자료형 별로 변수에 추가.
    func countType(){
        // JSON 배열을 반복문에 넣는다
        for value in self.dataSetOfJSON.values {
            // 각 항목별 체크
            countValue(value: value)
        }
    }
}

