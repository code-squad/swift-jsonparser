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
    func countTypes() -> (int: Int, string: Int, bool: Int, object: Int?)
}

/// JSON 배열타입 데이터
struct JSONArray : JSONCount {
    // 데이터를 배열로 담는다
    private let dataSetOfJSON : [Any]
    
    // 생성자
    init?(dataSetOfJSON : [Any]){
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
    
    /// JSON 배열 데이터중 입력받은 자료형 별로 변수에 추가.
    mutating func countType() -> Bool {
        // JSON 배열을 반복문에 넣는다
        for data in dataSetOfJSON {
            // 각 항목별 체크
            switch ObjectIdentifier(type(of: data)) {
            // 인트형일 경우
            case ObjectIdentifier(JSONParser.typeInt) : countOfInt += 1
            // 문자형일 경우
            case ObjectIdentifier(JSONParser.typeString) : countOfString += 1
            // Bool형일 경우
            case ObjectIdentifier(JSONParser.typeBool) : countOfBool += 1
            // 객체형일 경우
            case ObjectIdentifier(JSONParser.typeObject) : countOfObject += 1
            // 그 외의 경우
            default : return false
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
    // 데이터를 딕셔너리로 담는다
    private let dataSetOfJSON : [String : Any]
    
    // 생성자
    init?(dataSetOfJSON : [String : Any]){
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
    // 객체의 객체형 개수. 있을수 없기 때문에 닐 처리
    var countOfObject : Int? = nil
    
    /// JSON 배열 데이터중 입력받은 자료형 별로 변수에 추가.
    mutating func countType() -> Bool {
        // JSON 배열을 반복문에 넣는다
        for data in dataSetOfJSON.values {
            // 각 항목별 체크
            switch ObjectIdentifier(type(of: data)) {
            // 인트형일 경우
            case ObjectIdentifier(JSONParser.typeInt) : countOfInt += 1
            // 문자형일 경우
            case ObjectIdentifier(JSONParser.typeString) : countOfString += 1
            // Bool형일 경우
            case ObjectIdentifier(JSONParser.typeBool) : countOfBool += 1
            // 그 외의 경우
            default : return false
            }
        }
        return true
    }
    
    // 프로토콜을 준수한다
    func countTypes() -> (int: Int, string: Int, bool: Int, object: Int?) {
        return (countOfInt,countOfString,countOfBool,countOfObject)
    }
}

