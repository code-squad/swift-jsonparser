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
    
    // 배열인지 객체인지 표시하는 문자열
    let type : String { get }
}

/// JSON 에서 사용할 데이터 타입들을 선언
enum JSONData {
    case number(Int)
    case boolean(Bool)
    case letter(String)
    case object([String:JSONData])
    case array([JSONData])
}

/// JSON 배열타입 데이터
struct JSONArray : JSONCount {
    // 배열임을 표시한다
    var type = "배열"
    
    // 데이터를 배열로 담는다
    private let dataSetOfJSON : [JSONData]
    
    // 생성자
    init?(dataSetOfJSON : [JSONData]){
        self.dataSetOfJSON = dataSetOfJSON
        if countType() == false {
            return nil
        }
    }
    
    // 배열의 인트형 개수
    var countOfInt = 0
    // 배열의 문자형 개수
    var countOfString = 0
    // 배열의 Bool형 개수
    var countOfBool = 0
    // 배열의 객체형 개수
    var countOfObject = 0
    // 배열의 배열형 개수
    var countOfArray = 0
    
    /// JSON 배열 데이터중 입력받은 자료형 별로 변수에 추가.
    mutating func countType() -> Bool {
        // JSON 배열을 반복문에 넣는다
        for data in dataSetOfJSON {
            // 각 항목별 체크
            switch data {
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
        return true
    }
    
    
    // 프로토콜을 준수한다
    func countTypes() -> (int: Int, string: Int, bool: Int, object: Int?) {
        return (countOfInt,countOfString,countOfBool,countOfObject)
    }
}

/// JSON Object 타입
struct JSONObject : JSONCount {
    // 객체임을 표시한다
    var type = "객체"
    
    // 데이터를 딕셔너리로 담는다
    private let dataSetOfJSON : [String : JSONData]
    
    // 생성자
    init?(dataSetOfJSON : [String : JSONData]){
        self.dataSetOfJSON = dataSetOfJSON
        if countType() == false {
            return nil
        }
    }
    
    // 객체의 인트형 개수
    var countOfInt = 0
    // 객체의 문자형 개수
    var countOfString = 0
    // 객체의 Bool형 개수
    var countOfBool = 0
    // 객체의 객체형 개수
    var countOfObject = 0
    // 객체의 배열형 개수
    var countOfArray = 0
    
    /// JSON 배열 데이터중 입력받은 자료형 별로 변수에 추가.
    mutating func countType() -> Bool {
        // JSON 배열을 반복문에 넣는다
        for data in dataSetOfJSON.values {
            // 각 항목별 체크
            switch data {
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
        return true
    }
    
    // 프로토콜을 준수한다
    func countTypes() -> (int: Int, string: Int, bool: Int, object: Int?) {
        return (countOfInt,countOfString,countOfBool,countOfObject)
    }
}

