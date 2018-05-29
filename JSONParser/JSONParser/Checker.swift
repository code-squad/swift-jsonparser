//
//  swift
//  JSONParser
//
//  Created by Yoda Codd on 2018. 5. 23..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct Checker {
    /// 인트형 타입
    let typeInt : Int.Type = Int.self
    /// 문자형 타입
    let typeString : String.Type = String.self
    /// Bool 타입
    let typeBool : Bool.Type = Bool.self
    /// 객체형 타입
    private let emptyObject : [String:Any] = [:]
    
    
    /// 문자열을 받아서 JSON 문자형인지 체크
    func isLettersForJSON(letter : String) -> Bool {
        // 문자열의 첫번쨰와 마지막이 " 이면 참
        return letter[letter.startIndex] == JSON.letterWrapper && letter[letter.index(before:letter.endIndex)] == JSON.letterWrapper
    }
    
    /// 문자열을 받아서 JSON 객체의 문자형인지 체크
//    func checkObjectForJSON(letter : String) -> Bool {
//        // 문자열의 첫번쨰와 마지막이 " 이면 참
//        return letter[letter.startIndex] == JSON.startOfObjectOfJSON && letter[letter.index(before:letter.endIndex)] == JSON.endOfObjectOfJSON
//    }
    
    /// 문자열을 받아서 JSON 배열의 문자형인지 체크
    func checkArrayForJSON(letter : String) -> Bool {
        // 문자열의 첫번쨰와 마지막이 " 이면 참
        return letter[letter.startIndex] == JSON.startOfArrayOfJSON && letter[letter.index(before:letter.endIndex)] == JSON.endOfArrayOfJSON
    }
    
    /// JSON 배열 데이터중 입력받은 자료형 타입이 몇개인지 리턴
    private func countType(targetType : Any.Type, dataArray: [Any]) -> Int {
        // 결과값 변수 선언
        var countOfLetter = 0
        // JSON 배열을 반복문에 넣는다
        for data in dataArray {
            if ObjectIdentifier(type(of: data)) == ObjectIdentifier(targetType) {
                countOfLetter += 1
            }
        }
        return countOfLetter
    }
    
    /// JSON 객체 데이터중 입력받은 자료형 타입이 몇개인지 리턴
    private func countType(targetType : Any.Type, dataObject: [String:Any]) -> Int {
        // 결과값 변수 선언
        var countOfLetter = 0
        // JSON 배열을 반복문에 넣는다
        for data in dataObject.values {
            if ObjectIdentifier(type(of: data)) == ObjectIdentifier(targetType) {
                countOfLetter += 1
            }
        }
        return countOfLetter
    }
    // 타겟이 배열인 경우
    /// 입력한 배열에 인트형이 몇개인지 리턴
    func countIntFrom(targetArray : [Any]) -> Int {
        return countType(targetType: typeInt, dataArray: targetArray)
    }
    
    /// 입력한 배열에 인트형이 몇개인지 리턴
    func countStringFrom(targetArray : [Any]) -> Int {
        return countType(targetType: typeString, dataArray: targetArray)
    }
    
    /// 입력한 배열에 인트형이 몇개인지 리턴
    func countBoolFrom(targetArray : [Any]) -> Int {
        return countType(targetType: typeBool, dataArray: targetArray)
    }
    
    /// 입력한 배열에 인트형이 몇개인지 리턴
    func countObjectFrom(targetArray : [Any]) -> Int {
        return countType(targetType: type(of: emptyObject), dataArray: targetArray)
    }
    // 타겟이 객체인 경우
    /// 입력한 객체에 인트형이 몇개인지 리턴
    func countIntFrom(targetObject : [String:Any]) -> Int {
        return countType(targetType: typeInt, dataObject: targetObject)
    }
    
    /// 입력한 객체에 인트형이 몇개인지 리턴
    func countStringFrom(targetObject : [String:Any]) -> Int {
        return countType(targetType: typeString, dataObject: targetObject)
    }
    
    /// 입력한 객체에 인트형이 몇개인지 리턴
    func countBoolFrom(targetObject : [String:Any]) -> Int {
        return countType(targetType: typeBool, dataObject: targetObject)
    }
    
    /// 머리배열과 꼬리배열을 받아서 머리-꼬리 순서대로 배열을 합쳐서 리턴한다
    func combineByOrder(headIndexes: [String.Index], tailIndexes: [String.Index]) -> [String.Index] {
        // 리턴용 배열 선언
        var totalIndexes : [String.Index] = []
        // 개수만큼 반복문 진행
        for count in 0..<headIndexes.count {
            // 머리와 꼬리를 순서대로 넣는다
            totalIndexes.append(headIndexes[count])
            totalIndexes.append(tailIndexes[count])
        }
        // 결과를 리턴한다
        return totalIndexes
    }
    
    /// 머리 인덱스 배열과 꼬리 인덱스 배열을 받아서 머리~꼬리 사이에 다른 머리나 꼬리가 없는지 체크
    func checkOrderBetween(headIndexes: [String.Index], tailIndexes: [String.Index]) -> Bool {
        // 두 배열의 카운트가 같아야됨
        guard headIndexes.count == tailIndexes.count else {
            return false
        }
        // 두 인덱스를 순서대로 하나로 합침
        var totalIndexes  = combineByOrder(headIndexes: headIndexes, tailIndexes: tailIndexes)
        // 합쳐진 인덱스가 순서대로 나열 되어있는지 체크하기위해 통합 인덱스 배열을 반복문에 넣는다
        for count in 1..<totalIndexes.count {
            // 순서대로가 아닐경우 거짓 리텃
            guard totalIndexes[count-1] < totalIndexes[count] else {
                return false
            }
        }
        // 체크를 통과하면 참 리턴
        return true
    }
    
    /// 문자열을 받아서 {} 로 둘러싸여 있는지 체크
    func checkWrappedObjectStyle(letter : String) -> Bool {
        // 입력받은 문자열의 앞위가 {} 인지 체크한다
        if letter[letter.startIndex] == JSON.startOfObjectOfJSON && letter[letter.index(before:letter.endIndex)] == JSON.endOfObjectOfJSON {
            // 맞으면 앞뒤 두글자를 제외한 나머지 리턴. { } 와 그 사이의 빈칸을 제외
            return true
        }
        // {} 로 둘러싸여있지 않으면
        else {
            // 닐 리턴
            return false
        }
    }
    
    /// 문자열을 받아서 JSON 의 객체형 데이터에 들어갈수 있는지 체크
    private func checkDataTypeForJSONObject(letter : String) -> Bool {
        // 인트형이 가능한지 체크
        if Int(letter) != nil {
            return true
        }
            // Bool 타입인지 체크.
        else if JSON.booleanType.contains(letter){
            return true
        }
            // " 로 둘러쌓인 문자열인지 체크
        else if isLettersForJSON(letter: letter){
            return true
        }
            // 어느것도 매칭되지 않는다면 거짓 리턴
        else {
            return false
        }
    }
    
    /// 문자열을 받아서 : 를 기준으로 나누고 각 항목이 객체타입에 맞는지 체크
    private func checkObjectKeyValue(letter : String) -> Bool {
        // : 를 기준으로 나눈다
        let separatedObject = letter.split(separator: JSON.separaterForObject)
        // 키 부분 변수를 추출. 앞뒤로 빈칸이 있으니 제거해준다
        let keyOfObject = String(separatedObject[0]).trimmingCharacters(in: .whitespaces)
        // 키 부분이 " 로 둘러싸여있는지 체크
        guard isLettersForJSON(letter: keyOfObject) == true else {
            // "" 로 둘러쌓여 있지 않다면 거짓 리턴
            return false
        }
        // 키 부분 변수를 추출. 앞뒤 공백 제거
        let valueOfObject = String(separatedObject[1]).trimmingCharacters(in: .whitespaces)
        // 값 부분이 JSON 의 데이터형인지 체크
        return checkDataTypeForJSONObject(letter: valueOfObject)
        }
    
    /// {} 로 둘러 쌓이지 않은 문자열을 받아서 객체형인지 체크
    func checkUnWrappedObjectForJSON(letter: String) -> Bool {
        // , 를 기준으로 나눠서 배열로 만는다
        let separatedByComma = letter.split(separator: JSON.separater)
        // 각 키와 밸류를 반복문에 넣어서 JSON 타입이 맞는지 체크
        for object in separatedByComma {
            if checkObjectKeyValue(letter: String(object)) == false {
                return false
            }
        }
        // 모든 체크를 통과하면 참 리턴
        return true
    }
    
    /// {} 로 둘러쌓인 문자열을 받아서 객체형인지 체크
    func checkWrappedObjectForJSON(letter: String) -> Bool {
        // 맨 앞뒤가 {} 인지 체크
        guard checkWrappedObjectStyle(letter: letter) == true else {
            return false
        }
        // 맞다면 {} 를 제거
        let withoutWrapper = String(letter[letter.index(letter.startIndex, offsetBy: 1)..<letter.index(letter.endIndex, offsetBy: -1)])
        // {} 가 없는 객체형 체크 함수를 리턴한다
        return checkUnWrappedObjectForJSON(letter: withoutWrapper)
    }
    
}
