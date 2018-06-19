//
//  JSONParser.swift
//  JSONParser
//
//  Created by Yoda Codd on 2018. 5. 21..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct JSONParser {
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
    
    // JSON 데이터로 들어갈 수 있는 종류
    // 인트형 타입
    static let typeInt : Int.Type = Int.self
    // 문자형 타입
    static let typeString : String.Type = String.self
    // Bool 타입
    static let typeBool : Bool.Type = Bool.self
    // 객체형 타입
    static private let emptyObject : [String:JSONData] = [:]
    static let typeObject = type(of: emptyObject)
    
    /// 입력받은 문자열을 , 로 나눈 뒤 앞뒤 공백을 제거해서 배열로 리턴
    private func separate(letter : String, separator: Character = JSONParser.separater) -> [String]{
        // 뒤에서 함수에 사용할 문자형 배열 선언
        var separatedByComma : [String] = []
        // , 를 기준으로 나눠서 배열로 만든다
        let separatedSubSequencesByComma = letter.split(separator: separator)
        // , 기준으로 나눠진 배열을 반복문에 넣는다
        for subSequence in separatedSubSequencesByComma {
            // 앞뒤 공백 제거된 데이터를 결과에 추가한다
            separatedByComma.append(String(subSequence).trimmingCharacters(in: .whitespaces))
        }
        return separatedByComma
    }
    
    /// 문자열을 받아서 JSON 타입으로 리턴
     func transformValue(letter:String) -> JSONData? {
        // 인트형이 가능한지 체크. 변환가능하면 변환해서 추가
        if GrammarChecker.checkIntType(letter: letter) {
            return JSONData.number(Int(letter)!)
        }
            // Bool 타입인지 체크. 가능하면 변환해서 추가
        else if GrammarChecker.checkBoolType(letter: letter){
            return JSONData.boolean(Bool(letter)!)
        }
            // " 로 둘러쌓인 문자열인지 체크 후 추가
        else if GrammarChecker.checkStringType(letter: letter){
            return JSONData.letter(letter)
        }
            // [] 배열인지 체크 후 추가
        else if  GrammarChecker.checkArrayType(letter: letter) {
            guard let jsonData = transformArray(letter: letter) else {
                return nil
            }
            return jsonData
        }
        // 어느것도 매칭되지 않는다면 닐 리턴
        return nil
    }
    
    /// 문자열 배열을 받아서 배열형 JSONData 로 리턴한다
    private func makeJSONArrayType(array: [String]) -> JSONData?{
        // 나눠진 문자열을 데이터의 JSON 데이터로 변환한다
        var dataSet : [JSONData] = []
        // 자른 문자열을 데이터화 시킨다
        for letter in array {
            guard let transformedData = transformValue(letter: letter) else {
                return nil
            }
            dataSet.append(transformedData)
        }
        // 결과 리턴
        return .array(dataSet)
    }
    
    /// 입력받은 문자열의 앞뒤 1 문자씩 자르고 리턴
    private func cutClassifier(letter: String) -> String {
        return String(letter[letter.index(letter.startIndex, offsetBy: 1)..<letter.index(letter.endIndex, offsetBy: -1)])
    }
    
    /// [] 로 시작하는 문자열을 받아서 맨앞뒤를 제거하고 데이터화해주는 함수에 입력
    private func transformArray(letter : String) -> JSONData? {
        // 문자열의 분류자를 자른다
        let cuttedLetter = cutClassifier(letter: letter)
        // 문자열을 , 를 기준으로 자른다
        let separatedData = separate(letter: cuttedLetter)
        
        return makeJSONArrayType(array: separatedData)
    }
    
    /// 키:벨류 로 붙어있는 문자열을 받아서 키부분 리턴
    private func extractKeyFromObjectLetter(letter: String) -> String {
        // : 을 기준으로 문자열을 자른다
        let separatedLetter = letter.split(separator: JSONParser.separaterForObject)
        // 키 부분의 공백을 지워주고 변수화 한다
        let key = separatedLetter[0].trimmingCharacters(in: .whitespaces)
        // " 을 제외한 나머지 문자열을 내보낸다
        return key.replacingOccurrences(of: "\"", with: "")
    }
    
    /// 키:벨류 로 붙어있는 문자열을 받아서 벨류 부분 리턴
    private func extractValueFromObjectLetter(letter: String) -> JSONData? {
        // : 을 기준으로 문자열을 자른다
        let separatedLetter = letter.split(separator: JSONParser.separaterForObject)
        // 키 부분의 공백을 지워주고 변수화 한다
        let value = separatedLetter[1].trimmingCharacters(in: .whitespaces)
        // " 을 제외한 나머지 문자열을 내보낸다.
        return transformValue(letter: value)
    }
    
    /// , 로 나눠진 객체형 배열을 객체형 으로 만들어서 리턴
    private func combineSeparatedJSONObeject(letters: [String]) -> [String:JSONData]? {
        // 입력값이 JSON 객체형 데이터 인지 체크
        guard GrammarChecker.checkObjectValueTypes(types: letters) == true else {
            return nil
        }
        // 결과용 JSON 객체형을 선언한다
        var result : [String:JSONData] = [:]
        // 각 키와 밸류를 반복문에 넣어서 JSON 객체형으로 리턴
        for object in letters {
            // 키:벨류 형태의 문자열을 받아서 결과 객체에 추가한다
            let key = extractKeyFromObjectLetter(letter: String(object))
            guard let value = extractValueFromObjectLetter(letter: String(object)) else {
                return nil
            }
            result[key] = value
        }
        // 결과를 리턴한다
        return result
    }
    
    /// {} 로 둘러 쌓이지 않은 문자열을 받아서 객체형으로 리턴
    private func transformLetterToJSONObjectWithoutWrapper(letter: String) -> [String:JSONData]? {
        // , 기준으로 문자열을 나누고 앞뒤공백을 없앤다
        let separatedByComma = separate(letter: letter)
        // 각 키와 밸류를 반복문에 넣어서 JSON 타입이 맞는지 체크, 결과를 리턴한다
        return combineSeparatedJSONObeject(letters: separatedByComma)
    }
    
    /// {} 로 둘러쌓인 문자열을 받아서 JSON 객체형으로 리턴
    private func transformLetterToJSONObjectWithWrapper(letter: String) -> [String:JSONData]? {
        // 앞의 함수에서 체크된 대로 {} 를 제거
        let withoutWrapper = String(letter[letter.index(letter.startIndex, offsetBy: 1)..<letter.index(letter.endIndex, offsetBy: -1)])
        // {} 가 없는 객체형 체크 함수를 리턴한다
        return transformLetterToJSONObjectWithoutWrapper(letter: withoutWrapper)
    }
    
    /// 문자열을 받아서 JSON 타입으로 리턴
    private func transformValueOfJSONArray(letter:String) -> JSONData? {
        // {} 로 둘러쌓인 객체형인지 체크 후 추가
        if GrammarChecker.checkObjectType(letter: letter){
            guard let jsonData = transformLetterToJSONObjectWithWrapper(letter: letter) else {
                return nil
            }
            return JSONData.object(jsonData)
        }
        
        // 객체형을 제외한 데이터 타입 리턴함수 사용
        guard let transformedData = transformValue(letter: letter) else {
            // {} 이 외에 어느것도 매칭되지 않는다면 닐 리턴
            return nil
        }
        // 결과를 리턴
        return transformedData
    }    
    
    /// 문자열 배열을 받아서 JSON 배열로 생성. 변환 불가능한 값이 있으면 닐 리턴
    private func transformLettersToJSONArray(letters:[String]) -> [JSONData]? {
        // 결과 출력용 배열 선언
        var result :[JSONData] = []
        // 배열을 반복분에 넣는다
        for letter in letters {
            // JSON 에 추가 가능한지 체크. 변환가능하면 변환해서 추가
            guard let transformedValue = transformValueOfJSONArray(letter: letter) else {
                return nil
            }
            result.append(transformedValue)
        }
        // 결과 리턴
        return result
    }
    
    /// 문자열을 받아서 JSON 객체로 생성. 변환 불가능한 값이 있으면 닐 리턴
    func transform(letters:[String]) -> JSONCount? {
        // 첫번째 배열을 받아서 어떤 형태인지 파악한다
        let typeOfJSON = letters.first
        // 배열분류자 를 제외한 나머지 배열을 입력받는다
        var dataOfJSON = letters
        dataOfJSON.removeFirst()
        // 만약 배열형테면
        if typeOfJSON == "[" {
            // 문자열 배열을 JSON 배열 형태로 만든다
            guard let transformedLetters =  transformLettersToJSONArray(letters: dataOfJSON) else {
                return nil
            }
            // 결과를 리턴한다
            return JSONArray(dataSetOfJSON: transformedLetters)
        }
        // 객체 형태면
        else if typeOfJSON == "{" {
            // 문자열 배열을 JSON 객체 형태로 만든다
            guard let transformedLetters =  combineSeparatedJSONObeject(letters: dataOfJSON) else {
                return nil
            }
            // 결과를 리턴한다
            return JSONObject(dataSetOfJSON: transformedLetters)
        }
        // 배열, 객체 형태도 아니면 닐 리턴
        else { return nil }        
    }
    
    /// JSONCount 를 받아서 분석결과 리턴
    mutating func analyze(jsonCount: JSONCount ) -> JSONInformation {
        analyzeInformation(jsonData: jsonCount.dataSetOfJSON)
        return getInformation()
    }
    
    /// 문자열을 받아서 JSON 분석된 객체로 생성
    mutating func make(letters:[String]) -> JSONCount? {
        // 문자열을 받아서 JSONCount 로 생성
        guard var jsonCount = transform(letters: letters) else {
            return nil
        }
        
        // 생성된 JSON을 분석
        analyzeInformation(jsonData: jsonCount.dataSetOfJSON)
        let jsonInformaion = getInformation()
        // 분석된 결과를 입력
        jsonCount.jsonInformation = jsonInformaion
        //결과물 리턴
        return jsonCount
    }
    
    /// 분석결과를 클래스로 생성,리턴
    func getInformation() -> JSONInformation {
        let jsonInformation = JSONInformation()
        jsonInformation.countOfInt = countOfInt
        jsonInformation.countOfBool = countOfBool
        jsonInformation.countOfString = countOfString
        jsonInformation.countOfArray = countOfArray
        jsonInformation.countOfObject = countOfObject
        jsonInformation.detailOfJSON = detailOfJSON
        return jsonInformation
    }
    
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
            // 카운트 함수를 실행한다
            plusArrayCount()
            // 배열 시작시 탭 추가
            tabSize += 1
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
            // 카운트 함수를 실행한다
            plusObjectCount()
            // 객체 시작시 탭추가
            tabSize += 1
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
    
    /// JSON을 받아서 분석한다. 타입개수, 프린트문 생성
    mutating func analyzeInformation(jsonData: JSONData){
        // 내용 출력용 변수에 내용 입력
        detailOfJSON = makePrint(json: jsonData)
        // 마지막 문자가 ] 인 경우 줄바꿈을 추가해 준다
        if detailOfJSON.last == "]" {
            detailOfJSON.removeLast()
            detailOfJSON += "\n ]"
        }
    }
}

