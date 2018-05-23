//
//  Classifier.swift
//  JSONParser
//
//  Created by Yoda Codd on 2018. 5. 15..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct Classifier{
    
    /// 문자열을 받아서 목표문자의 위치 인덱스를 배열로 리턴
    fileprivate func surveyLetterPositions(letters : String, targetLetter : Character) -> [String.Index]? {
        // 문자가 한개도 없으면 닐 리턴
        guard letters.index(of: targetLetter) != nil else{
            return nil
        }
        // 인덱스 기록용 변수
        var targetLetterIndex = letters.startIndex
        // 리턴용 배열 선언
        var result : [String.Index] = []
        // 반복문 온 오프 플래그
        var repeatable = true
        // 반복문 시작
        repeat {
            // 문자 위치 변수. 문자가 없을경우 문자열의 끝을 표시
            let nextCharaterIndex = letters[targetLetterIndex..<letters.endIndex].index(of: targetLetter) ?? letters.endIndex
            // 문자가 뒤에 더 있으면
            if nextCharaterIndex != letters.endIndex {
                // , 위치를 저장한다
                result.append(nextCharaterIndex)
                // 문자 다음 글자를 가리킨다
                targetLetterIndex = letters.index(after:nextCharaterIndex)
                // 마지막일 경우
            } else {
                // 반복문을 종료한다
                repeatable = false
            }
            // 위치 체크용 플래그가 문자열의 마지막을 가리키면 반복문 종료
        } while repeatable
        // 결과를 리턴한다
        return result
    }
    
    /// 문자열을 받아서 특정 캐릭터로 둘러쌓인 부분의 인덱스를 배열로 리턴
    fileprivate func surveyLetterRange(letters : String, targetLetter : Character) -> [Range<String.Index>]? {
        // 문자의 위치를 가진 배열 선언. 목표문자가 한개도 없으면 닐 리턴
        guard let letterIndexList = surveyLetterPositions(letters: letters, targetLetter: targetLetter) else {
            return nil
        }
        // 범위를 구해야 하기 때문에 문자의 개수가 짝수인지 체크
        guard letterIndexList.count % 2 == 0 else {
            // 홀수면 닐 리턴
            return nil
        }
        // 결과 리턴용 배열
        var result : [Range<String.Index>] = []
        // 앞문자열 위치 저장
        var headLetterIndex = letters.startIndex
        // 뒷문자열 위치 저장
        var tailLetterIndex : String.Index
        // 두가지를 조합하기 위한 조건문용 플래그
        var readyForHead = true
        // 문자위치 배열을 반복문에 돌린다
        for letterIndex in letterIndexList {
            // 첫 입력이라면
            if readyForHead  {
                // 앞쪽 인덱스를 입력하고
                headLetterIndex = letterIndex
                // 플래그를 오프
                readyForHead = false
            // 이미 앞쪽 인덱스가 존재한다면
            } else {
                // 뒤쪽 인덱스를 포함하도록 인덱스+1 을 입력
                tailLetterIndex = letters.index(after:letterIndex)
                // 앞인덱스와 뒤인덱스의 범위를 결과배열에 추가
                result.append(headLetterIndex..<tailLetterIndex)
                // 앞쪽 인덱스를 입력받을 준비를 한다
                readyForHead = true
            }
        }
        // 결과를 리턴한다
        return result
    }
    
    /// 인덱스배열과 레인지배열을 받아서 레인지범위 안에 있는 인덱스를 로외한 인댁스배열을 리턴
    fileprivate func removeDuplicatedIndexIn(indexRangeList : [Range<String.Index>], targetIndexes : [String.Index]) -> [String.Index]{
        // 리턴용 인덱스 배열
        var resultIndexList : [String.Index] = []
        // 제거할 목표 인덱스 배열을 반복문에 넣는다
        for targetIndex in targetIndexes {
            // 레인지범위에 인덱스가 있는지 체크하는 플래그
            var isContaindedIndex = false
            // 인덱스 레인지를 반복문에 넣는다
            for indexRagne in indexRangeList {
                // 범위에 포함될 경우 플래그 온
                if indexRagne.contains(targetIndex){
                    isContaindedIndex = true
                }
            }
            // 한 인덱스가 모든 레인지범위에 포함되지 않았으면 결과에 추가해준다
            if isContaindedIndex == false {
                resultIndexList.append(targetIndex)
            }
        }
        // 결과를 리턴
        return resultIndexList
    }
    
    /// 문자열을 받아서 목표문자배열을 받아서 그 목표문자인덱스를 기준으로 나누어 레인지 인덱스 배열로 생성한다
    fileprivate func separateByIndexes(letters : String, targetIndexes : [String.Index]) -> [Range<String.Index>] {
        // 쉼표 다음지점을 체크하기 위한 플래그
        var indexFlag = letters.startIndex
        // 결과 리턴용 배열
        var result : [Range<String.Index>] = []
        //입력받은 인덱스 리스트를 반복
        for targetIndex in targetIndexes {
            // 앞지점과 타겟인덱스 앞칸의 범위를 결과에 저장
            result.append(indexFlag..<targetIndex)
            // 타겟인덱스 뒤칸을 플래그에 저장
            indexFlag = letters.index(after:targetIndex)
        }
        // 마지막 인덱스가 문자열의 끝이 아니라면
        if indexFlag != letters.endIndex {
            // 마지막 인덱스 ~ 끝 부분을 추가해준다
            result.append(indexFlag..<letters.endIndex )
        }
        // 결과를 리턴한다
        return result
    }
    
    /// 문자열을 받아서 쉼표를 기준으로 나누어 레인지 인덱스 배열로 생성한다
    fileprivate func separateByCommaIndexes(letters : String) -> [Range<String.Index>] {
        // 쉼표 다음지점을 체크하기 위한 플래그
        var indexFlag = letters.startIndex
        // 결과 리턴용 배열
        var result : [Range<String.Index>] = []
        //입력받은 문자열 전체를 돈다
        repeat {
            // 쉼표 위치 변수. 쉼표가 없을경우 문자열의 끝을 표시
            let commaPosition = letters[indexFlag..<letters.endIndex].index(of: ",") ?? letters.endIndex
            // 해당 부분을 잘라서 문자형 배열에 추가
            result.append(indexFlag..<commaPosition)
            // 쉼표가 뒤에 더 있으면
            if commaPosition != letters.endIndex {
                // 쉼표 다음 글자를 가리킨다
                indexFlag = letters.index(after:commaPosition)
                // 마지막일 경우
            } else {
                // 문자열의 마지막을 가리킨다
                indexFlag = letters.endIndex
            }
            // 위치 체크용 플래그가 문자열의 마지막을 가리키면 반복문 종료
        } while indexFlag != letters.endIndex
        // 결과를 리턴한다
        return result
    }
    
    /// JSON 입력값을 받아서 , 기준으로 자르는 함수, " " 로 둘러쌓인 문자열 안의 , 는 자르지 않는다
        func surveyLettersByJSON(letters : String) -> [String]?{
            // 결과 리턴용 변수
            var result : [String] = []
            // 문자열의 , 인덱스를 구한다
            guard var commaIndexes = surveyLetterPositions(letters: letters, targetLetter: JSON.separater) else {
                return nil
            }
            // " 로 둘러쌓인 범위인덱스를 구한다
            guard let doubleQuatationIndexes = surveyLetterRange(letters: letters, targetLetter: JSON.letterWrapper) else {
                return nil
            }
            // , 중 " 로 둘러쌓인 인덱스를 제외시킨다
            commaIndexes = removeDuplicatedIndexIn(indexRangeList: doubleQuatationIndexes, targetIndexes: commaIndexes)
            // , 를 기준으로 문자열을 나눈 범위인덱스를 구한다
            let separatedByIndexex = separateByIndexes(letters: letters, targetIndexes: commaIndexes)
            // , 인덱스를 기준으로 문자열을 나누어서 문자열로 리턴한다
            for separatedByIndex in separatedByIndexex {
                result.append(String(letters[separatedByIndex]))
            }
            // 결과를 리턴한다
            return result
        }
    
    /// 문자형 배열을 받아서 인트형으로 바뀔수 있는 개수를 리턴
    func countNumberFrom(letters : [String]) -> Int {
        // 결과값 리턴을 위한 카운트 변수
        var countNumber = 0
        // 문자형 배열을 반복한다
        for number in letters {
            // 인트형으로 변환이 가능하면
            if Int(number) != nil {
                // 결과값 +1 을 한다
                countNumber += 1
            }
        }
        // 결과값 리턴
        return countNumber
    }
    
    /// 문자형 배열을 받아서 false, true 에 맞는 항목이 몇개인지 리턴
    func countBooleanFrom(letters : [String]) -> Int {
        // 결과값 리턴을 위한 카운트 변수
        var countBoolean = 0
        // 문자형 배열을 반복한다
        for boolean in letters {
            // true or false 이면
            if JSON.booleanType.contains(boolean) {
                // 결과값 +1 을 한다
                countBoolean += 1
            }
        }
        // 결과값 리턴
        return countBoolean
    }
    
    /// 문자형 배열을 받아서 \" 로 둘라쌓인 항목이 몇개인지 리턴
    func countDoubleQuatationLettersFrom(letters : [String]) -> Int {
        // 결과값 리턴을 위한 카운트 변수
        var countDoubleQuatation = 0
        // 문자형 배열을 반복한다
        for letter in letters {
            // 처음과 끝이 \" 일 경우
            if Checker.isLettersForJSON(letter: letter) {
                // 결과값 +1 을 한다
                countDoubleQuatation += 1
            }
        }
        // 결과값 리턴
        return countDoubleQuatation
    }
    /// 문자열을 받아서 JSON 타입으로 리턴
    func transformLetterToValueOfJSON(letter:String) -> Any? {
        // 인트형이 가능한지 체크. 변환가능하면 변환해서 추가
        if Int(letter) != nil {
            return Int(letter)!
        }
        // Bool 타입인지 체크. 가능하면 변환해서 추가
        else if JSON.booleanType.contains(letter){
            return Bool(letter)!
        }
        // " 로 둘러쌓인 문자열인지 체크 후 추가
        else if Checker.isLettersForJSON(letter: letter){
            return (letter)
        }
        // 어느것도 매칭되지 않는다면 닐 리턴
        else {return nil}
    }
    
    /// 문자열 배열을 받아서 JSON 객체로 생성. 변환 불가능한 값이 있으면 닐 리턴
    func transformLettersToJSON(letters:[String]) -> [Any]? {
        // 결과 출력용 배열 선언
        var result :[Any] = []
        // 배열을 반복분에 넣는다
        for letter in letters {
            // JSON 에 추가 가능한지 체크. 변환가능하면 변환해서 추가
            guard let transformedValue = transformLetterToValueOfJSON(letter: letter) else {
                return nil
            }
            result.append(transformedValue)
        }
        // 결과 리턴
        return result
    }
    
    /// 문자열을 받아서 JSON JSON 객체로 생성. 변환 불가능한 값이 있으면 닐 리턴
    func transformLetterToJSON(letter:String) -> [Any]? {
        // 문자열을 받아서 JSON 스타일로 배열화 한다
        guard let letters = surveyLettersByJSON(letters: letter) else {
            return nil
        }
        // 문자열 배열을 JSON 형태로 만든다
        guard let transformedLetters =  transformLettersToJSON(letters: letters) else {
            return nil
        }
        // 결과를 리턴한다
        return transformedLetters
    }
}
