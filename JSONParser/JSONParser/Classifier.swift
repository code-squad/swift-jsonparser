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
    private func surveyLetterPositions(letters : String, targetLetter : Character) -> [String.Index]? {
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
    
    /// 문자열을 받고 인덱스 배열을 받아서 인덱스로 둘러쌓인 문자열 범위를 리턴한다
    private func surveyWrappedRange(letters : String, letterIndexList : [String.Index]) -> [Range<String.Index>]? {
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
    
    /// 문자열을 받아서 특정 캐릭터로 둘러쌓인 부분의 인덱스를 배열로 리턴
    private func surveyLetterRange(letters : String, targetLetter : Character) -> [Range<String.Index>]? {
        // 문자의 위치를 가진 배열 선언. 목표문자가 한개도 없으면 닐 리턴
        guard let letterIndexList = surveyLetterPositions(letters: letters, targetLetter: targetLetter) else {
            return nil
        }
        // 인덱스로 둘러쌓인 인덱스 레인지 배열을 리턴해주는 함수를 리턴한다
        return surveyWrappedRange(letters: letters, letterIndexList: letterIndexList)
    }
    
    /// 인덱스배열과 레인지배열을 받아서 레인지범위 안에 있는 인덱스를 제외한 인댁스배열을 리턴
    private func removeDuplicatedIndexIn(indexRangeList : [Range<String.Index>], targetIndexes : [String.Index]) -> [String.Index]{
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
    
    
    /// 문자열과 인덱스배열을 받아서 그 인덱스를 기준으로 나누어 레인지 인덱스 배열로 생성한다
    private func separateByIndexes(letters : String, targetIndexes : [String.Index]) -> [Range<String.Index>] {
        // 쉼표 다음지점을 체크하기 위한 플래그
        var indexFlag = letters.startIndex
        // 결과 리턴용 배열
        var result : [Range<String.Index>] = []
        //입력받은 인덱스 리스트를 반복
        for targetIndex in targetIndexes {
            // 앞지점과 타겟인덱스 앞칸의 범위를 결과에 저장
            result.append(indexFlag..<targetIndex)
            // 타겟인덱스 2칸 뒤를 플래그에 저장. JSON 데이터는 , 뒤에 빈칸을 한칸 두기 때문에 두칸 다음이 다음 데이터의 시작임
            indexFlag = letters.index(targetIndex, offsetBy:2)
        }
        // 마지막 인덱스가 문자열의 끝이 아니라면
        if indexFlag != letters.endIndex {
            // 마지막 인덱스 ~ 끝 부분을 추가해준다
            result.append(indexFlag..<letters.endIndex )
        }
        // 결과를 리턴한다
        return result
    }
    /// 문자열을 입력받아서 { } 로 둘러쌓인 부분을 범위인덱스 배열로 리턴한다
    private func surveyObjectRanges(letters : String) -> [Range<String.Index>]?{
        // { 와 } 각각 인덱스 배열을 만든다
        guard let headIndexes = surveyLetterPositions(letters: letters, targetLetter: JSONParser.startOfObjectOfJSON) else {
            return nil
        }
        guard let tailIndexes = surveyLetterPositions(letters: letters, targetLetter: JSONParser.endOfObjectOfJSON) else {
            return nil
        }
        //  { } 의 위치에 문제는 없는지 체크한다
        guard Checker.checkOrderBetween(headIndexes: headIndexes, tailIndexes: tailIndexes) else {
            return nil
        }
        // 두 배열을 머리-꼬리,머리-꼬리 순으로 합친다
        let objectIndexes = Checker.combineByOrder(headIndexes: headIndexes, tailIndexes: tailIndexes)
        // 인덱스 배열로 둘러쌓인 인덱서 범위 배열로 리턴해주는 함수를 리턴한다
        return surveyWrappedRange(letters: letters, letterIndexList: objectIndexes)
    }
    
    /// JSON 입력값을 받아서 , 기준으로 자르는 함수, " " 로 둘러쌓인 문자열 안의 , 는 자르지 않는다
    func separateForJSON(letters : String) -> [String]?{
        // 입력값이 배열 혹은 객체 형태여야만 함.
        guard Checker.checkArrayForJSON(letter: letters) || Checker.checkWrappedObjectStyle(letter: letters) else {
            // 둘 다 아닐경우 닐 리턴
            return nil
        }
        // 결과 리턴용 변수
        var result : [String] = []
        // 문자열의 , 인덱스를 구한다
        guard var commaIndexes = surveyLetterPositions(letters: letters, targetLetter: JSONParser.separater) else {
            return nil
        }
        // " 로 둘러쌓인 범위인덱스를 구한다
        guard let doubleQuatationIndexes = surveyLetterRange(letters: letters, targetLetter: JSONParser.letterWrapper) else {
            return nil
        }
        // , 중 " 로 둘러쌓인 인덱스를 제외시킨다
        commaIndexes = removeDuplicatedIndexIn(indexRangeList: doubleQuatationIndexes, targetIndexes: commaIndexes)
        // 배열형일 경우 추가로 { } 관련 인덱스 작업을 해준다
        if Checker.checkArrayForJSON(letter: letters) {
            // { } 로 둘러쌓인 범위인덱스를 구한다
            guard let objectIndexes = surveyObjectRanges(letters: letters) else {
                return nil
            }
            // , 중 {} 로 둘러쌓인 인덱스를 제외시킨다
            commaIndexes = removeDuplicatedIndexIn(indexRangeList: objectIndexes, targetIndexes: commaIndexes)
        }
        // , 를 기준으로 문자열을 나눈 범위인덱스를 구한다
        let separatedByIndexes = separateByIndexes(letters: letters, targetIndexes: commaIndexes)
        // , 인덱스를 기준으로 문자열을 나누어서 문자열로 리턴한다
        for separatedByIndex in separatedByIndexes {
            result.append(String(letters[separatedByIndex]))
        }
        // 결과를 리턴한다
        return result
    }
    
    /// 문자열을 받아서 맨 앞뒤 글자를 자르고 분류함수로 보낸다. 분류후 함수에 잘랐던 맨 앞글자를 insert 해서 리턴한다.
    func surveyForJSON(letters : String) -> [String]?{
        // , 를 기준으로 자른다
        guard var separatedLetters = separateForJSON(letters: letters) else {
            return nil
        }
        // 맨 앞의 분류자를 변수처리한다. 결과값에선 삭제한다.
        let flag = separatedLetters[0].removeFirst()
        // 맨 앞에 분류자를 넣어준다
        separatedLetters.insert(String(flag), at: 0)
        // 맨뒤의 분류자를 삭제한다
        separatedLetters[separatedLetters.count-1].removeLast()
        // 결과를 리턴한다
        return separatedLetters
    }
}
