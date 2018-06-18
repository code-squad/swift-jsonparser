//
//  OutView.swift
//  JSONParser
//
//  Created by Yoda Codd on 2018. 5. 21..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
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
    // 객체형 출력시 앞의 공백을 저장하는 변수
    var tabSize = 0
    // 내용을 JSON 스타일로 출력하게될 변수
    var detailOfJSON = ""
    
    /// 탭사이즈가 1이면 인트 카운트 변수를 +1 해준다
    mutating func plusIntCount(){
        if tabSize == 1 {
            countOfInt += 1
        }
    }
    /// 탭사이즈가 1이면 문자열 카운트 변수를 +1 해준다
    mutating func plusStringCount(){
        if tabSize == 1 {
            countOfString += 1
        }
    }
    /// 탭사이즈가 1이면 Bool 카운트 변수를 +1 해준다
    mutating func plusBoolCount(){
        if tabSize == 1 {
            countOfBool += 1
        }
    }
    /// 탭사이즈가 1이면 배열 카운트 변수를 +1 해준다
    mutating func plusArrayCount(){
        if tabSize == 1 {
            countOfArray += 1
        }
    }
    /// 탭사이즈가 1이면 객체 카운트 변수를 +1 해준다
    mutating func plusObjectCount(){
        if tabSize == 1 {
            countOfObject += 1
        }
    }
    
    /// 줄바꿈 + 탭 * 탭사이즈 를 리턴해주는 함수
    func newLine() -> String {
        // 결과 출력용 변수
        var result = "\n"
        // 탭사이즈가 0 이하 일 경우 탭 없이 리턴한다
        if tabSize < 1 {
            return result
        }
        // 1부터 tabSize 횟수만큼 \t 을 더해준다
        for _ in 1...tabSize {
            result += "\t"
        }
        // 결과를 리턴한다
        return result
    }
    
    /// 프린트를 위한 함수
    mutating func makePrint(json: JSONData) -> String{
        // json 을 반복문에 switch case 에 넣는다
        switch json {
        case .array(let array) :
            // [ 로 배열 출력문을 시작한다
            var result = " ["
            // 배열 시작시 탭 추가
            tabSize += 1
            // 카운트 함수를 실행한다
            plusArrayCount()
            for value in array {
                // 값만 추가한다
                result += makePrint(json: value)
                // 마지막 문자가 } 일 경우 , 이후에 줄바꿈을 추가한다
                if result.last == "}" {
                    result += ","+newLine()
                } // 이외에는 줄바꿈 없이 , 만 추가한다
                else {
                    result += ","
                }
            }
            // 마지막 , 를 삭제한다
            result.removeLast()
            // 배열 종료시 탭 줄임
            tabSize -= 1
            // 마지막에 ], 를 추가하고 리턴한다
            return result+" ]"
            
        case .object(let object) :
            // { 로 결과출력문을 시작한다
            var result = " {"
            // 객체 시작시 탭추가
            tabSize += 1
            // 카운트 함수를 실행한다
            plusObjectCount()
            // 뉴라인 + 추가된 탭 추가
            result += newLine()
            // 객체를 반복문에 넣는다
            for value in object {
                // 결과 메세지에 키 : 밸류, 순으로 추가
                result += " \"\(value.key)\" :" + makePrint(json: value.value) + ","
                // 뉴라인 후 탭사이즈 추가
                result += newLine()
            }
            // 마지막의 줄바꿈문자, 탭사이즈, 콤마 를 삭제한다
            result.removeLast(tabSize+2)
            // 객체가 끝났기 때문에 탭사이즈를 줄여준다
            tabSize -= 1
            // 마지막에 뉴라인, 탭사이즈, } 를 추가하고 리턴한다
            return result+newLine()+" }"
        // 그 외의 경우는 바로 리턴해준다
        case .letter(let string) :
            // 카운트 함수를 실행한다
            plusStringCount()
            return (" \(string)")
        case .boolean(let bool) :
            // 카운트 함수를 실행한다
            plusBoolCount()
            return (" \(bool)")
        case .number(let number) :
            // 카운트 함수를 실행한다
            plusIntCount()
            return (" \(number)")
        }
    }
    
    /// JSON 데이터를 받아서 각 항목이 몇개인지 출력
    func printCount(jsonType: String) {
        // 결과 출력용 메세지
        var resultCountMessage = " 데이터 중에"
        let endCountMessage = "가 포합되어 있습니다."
        // 0개 이상의 경우 메세지를 추가한다
        if countOfInt > 0 {
            resultCountMessage += " 숫자 \(countOfInt)개,"
        }
        if countOfString > 0 {
            resultCountMessage += " 문자열 \(countOfString)개,"
        }
        if countOfBool > 0 {
            resultCountMessage += " 부울 \(countOfBool)개,"
        }
        if countOfObject > 0 {
            resultCountMessage += " 객체 \(countOfObject)개,"
        }
        if countOfArray > 0 {
            resultCountMessage += " 배열 \(countOfArray)개,"
        }
        // 맨 뒤의 , 를 삭제한다.
        resultCountMessage.removeLast()
        // 총 합을 구한다
        let totalCount = countOfInt + countOfString + countOfBool + countOfObject + countOfArray
        
        // 요구조건의 형태대로 카운트 출력
        print("총 \(totalCount)개의 \(jsonType) 데이터 중에\(resultCountMessage)\(endCountMessage)")
    }
    
    /// JSON을 받아서 분석한다. 타입개수, 프린트문 생성
    mutating func analysis(json: JSONCount){
        // 내용 출력용 변수에 내용 입력
        detailOfJSON = makePrint(json: json.dataSetOfJSON)
        // 마지막 문자가 ] 인 경우 줄바꿈을 추가해 준다
        if detailOfJSON.last == "]" {
            detailOfJSON.removeLast()
            detailOfJSON += "\n ]"
        }
    }
    
    /// JSON의 내용을 출력해준다.
    func printDetail(){
        print (detailOfJSON)
    }
    
    /// 요구조건에서 요구하는 내용을 출력한다
    mutating func printJSON(json: JSONCount){
        // 카운팅, 디테일을 작성한다
        analysis(json: json)
        // 카운트를 출력한다
        printCount(jsonType: json.type)
        // 세부 내용을 출력한다
        printDetail()
    }
}
