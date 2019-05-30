//
//  Tokenizer.swift
//  JSONParser
//
//  Created by jang gukjin on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Tokenizer {
    var arrayJson: [String] = []
    var dictionaryJson = [String:String]()
    var inputElement: [String] = []
    var countPattern = ["dictionary":0,"array":0,"string":0]
    
    /// 입력받은 문자열이 nil인지 아닌지 판단 및 옵셔널 바인딩 함수
    private func distinctNil(input: String?) throws -> String {
        guard let notOptionalText: String = input else { throw ErrorMessage.wrongValue }
        return notOptionalText
    }
    
    /// "{","\"","[","]","}"를 검사하여 해당 원소가 어디까지인지 판단하는 함수
    private func patternInspect(index: String.Index, inputText: String, countPattern: [String:Int]) -> [String:Int] {
        var counts = countPattern
        let countDictionary = countPattern["dictionary"]!
        let countString = countPattern["string"]!
        let countArray = countPattern["array"]!
        if inputText[index] == Sign.frontCurlyBracket {
            counts["dictionary"] = countDictionary + 1
        } else if counts["string"] == 0, inputText[index] == Sign.doubleQuote {
            counts["string"] = countString + 1
        } else if inputText[index] == Sign.frontSquareBracket {
            counts["array"] = countArray + 1
        } else if counts["dictionary"]! > 0, inputText[index] == Sign.backCurlyBracket {
            counts["dictionary"] = countDictionary - 1
        } else if counts["string"]! > 0, inputText[index] == Sign.doubleQuote {
            counts["string"] = countString - 1
        } else if counts["array"]! > 0, inputText[index] == Sign.backSquareBracket {
            counts["array"] = countArray - 1
        }
        return counts
    }
    
    /// 입력받은 문자의 양 끝의 괄호를 제거해주는 함수
    private func removeBothSides(inputText: String) -> String {
        var textToAnalyze = inputText
        textToAnalyze.removeLast()
        textToAnalyze.removeFirst()
        return textToAnalyze
    }
    
    /// 한 문자씩 넣은 원소들을 다시 합하여 하나의 원소로 넣는 함수
    mutating private func inputData(){
        var input = inputElement.joined()
        let inputDatum = input.trimmingCharacters(in: CharacterSet(charactersIn: "\(Sign.comma)"))
        input = inputDatum.trimmingCharacters(in: .whitespacesAndNewlines)
        inputElement = []
        arrayJson.append(input)
    }
    
    /// 한 문자씩 넣은 원소들을 합칠 조건을 판단하고 합치는 함수
    private mutating func determineWhenToCombine(index: String.Index, textToAnalyze: String) throws {
        if (countPattern["dictionary"] == 0 && countPattern["string"] == 0 && countPattern["array"] == 0) && (textToAnalyze[index] == Sign.comma || index == textToAnalyze.index(before: textToAnalyze.endIndex)) {
            inputData()
        } else if countPattern["dictionary"] == 0, countPattern["string"] == 0, countPattern["array"] == 0, textToAnalyze[index] == Sign.colon {
            throw ErrorMessage.invalidFormat
        }
    }
    
    /// 입력받은 문자열이 배열의 형태인 경우 Token들을 나누고 이들을 배열의 형태로 다시 만드는 함수
    mutating func buildArray(inputString: String) throws -> [String] {
        let textToAnalyze = removeBothSides(inputText: inputString)
        for index in textToAnalyze.indices {
            countPattern = patternInspect(index: index, inputText: textToAnalyze, countPattern: countPattern)
            inputElement.append(String(textToAnalyze[index]))
            try determineWhenToCombine(index: index, textToAnalyze: textToAnalyze)
        }
        return arrayJson
    }
    
    /// 배열의 원소들을 조합해서 딕셔너리로 만드는 함수
    mutating func combinateElement(index: Int) throws {
        if index % 2 == 0, arrayJson[index].last == Sign.colon {
            arrayJson[index] = arrayJson[index].trimmingCharacters(in: CharacterSet(charactersIn: "\(Sign.colon)"))
            arrayJson[index] = arrayJson[index].trimmingCharacters(in: .whitespacesAndNewlines)
            dictionaryJson[arrayJson[index]] = arrayJson[index+1]
        } else {
            throw ErrorMessage.invalidFormat
        }
    }
    
    /// 입력받은 문자열이 딕셔너리 형태인 경우 Token들을 나누고 이들을 딕셔너리 형태로 다시 만드는 함수
    mutating func buildDictionary(inputString: String) throws -> [String:String] {
        let textToAnalyze = removeBothSides(inputText: inputString)
        for i in textToAnalyze.indices {
            countPattern = patternInspect(index: i, inputText: textToAnalyze, countPattern: countPattern)
            inputElement.append(String(textToAnalyze[i]))
            if (countPattern["dictionary"] == 0 && countPattern["string"] == 0 && countPattern["array"] == 0) && (textToAnalyze[i] == Sign.comma || textToAnalyze[i] == Sign.colon || i == textToAnalyze.index(before: textToAnalyze.endIndex)) {
                inputData()
            }
        }
        if arrayJson.count == 1 {
            throw ErrorMessage.invalidFormat
        }
        for index in 0..<arrayJson.count-1 {
            try combinateElement(index: index)
        }
        return dictionaryJson
    }
    
    /// 한 문자씩 Scan하고 Token으로 나누는 함수
    mutating func scannerAndTokenizer(text: String?) throws{
        let inputString = try distinctNil(input: text)
        if inputString.match(text: RegularExpression.arrayType) {
            arrayJson = try buildArray(inputString: inputString)
        } else if inputString.match(text: RegularExpression.dictionaryType) {
            dictionaryJson = try buildDictionary(inputString: inputString)
        } else {
            throw ErrorMessage.notArray
        }
    }

}
