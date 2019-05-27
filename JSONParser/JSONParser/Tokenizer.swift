//
//  Tokenizer.swift
//  JSONParser
//
//  Created by jang gukjin on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Tokenizer: JsonParserable {
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
        if inputText[index] == Sign.frontCurlyBracket {
            counts["dictionary"] = counts["dictionary"] ?? 0 + 1
        } else if counts["string"] == 0, inputText[index] == Sign.doubleQuote {
            counts["string"] = counts["string"] ?? 0 + 1
        } else if inputText[index] == Sign.frontSquareBracket {
            counts["array"] = counts["array"] ?? 0 + 1
        } else if counts["dictionary"] ?? 0 > 0, inputText[index] == Sign.backSquareBracket {
            counts["dictionary"] = counts["dictionary"]! - 1
        } else if counts["string"] ?? 0 > 0, inputText[index] == Sign.doubleQuote {
            counts["string"] = counts["string"]! - 1
        } else if counts["array"] ?? 0 > 0, inputText[index] == Sign.backSquareBracket {
            counts["array"] = counts["array"]! - 1
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
    
    /// 입력받은 문자열이 배열의 형태인 경우 Token들을 나누고 이들을 배열의 형태로 다시 만드는 함수
    private mutating func buildArray(inputString: String) -> [String] {
        let textToAnalyze = removeBothSides(inputText: inputString)
        for i in textToAnalyze.indices {
            countPattern = patternInspect(index: i, inputText: textToAnalyze, countPattern: countPattern)
            inputElement.append(String(textToAnalyze[i]))
            if (countPattern["dictionary"] == 0 && countPattern["string"] == 0 && countPattern["array"] == 0) && (textToAnalyze[i] == Sign.comma || i == textToAnalyze.index(before: textToAnalyze.endIndex)) {
                inputData()
            }
        }
        return arrayJson
    }
    
    /// 입력받은 문자열이 딕셔너리 형태인 경우 Token들을 나누고 이들을 딕셔너리 형태로 다시 만드는 함수
    private mutating func buildDictionary(inputString: String) -> [String:String] {
        let textToAnalyze = removeBothSides(inputText: inputString)
        for i in textToAnalyze.indices {
            countPattern = patternInspect(index: i, inputText: textToAnalyze, countPattern: countPattern)
            inputElement.append(String(textToAnalyze[i]))
            if (countPattern["dictionary"] == 0 && countPattern["string"] == 0 && countPattern["array"] == 0) && (textToAnalyze[i] == Sign.comma || textToAnalyze[i] == Sign.colon || i == textToAnalyze.index(before: textToAnalyze.endIndex)) {
                inputData()
            }
        }
        for j in 0..<arrayJson.count-1 {
            if j % 2 == 0, arrayJson[j].last == Sign.colon {
                arrayJson[j] = arrayJson[j].trimmingCharacters(in: CharacterSet(charactersIn: "\(Sign.colon)"))
                arrayJson[j] = arrayJson[j].trimmingCharacters(in: .whitespacesAndNewlines)
                dictionaryJson[arrayJson[j]] = arrayJson[j+1]
            }
        }
        return dictionaryJson
    }
    
    /// 한 문자씩 Scan하고 Token으로 나누는 함수
    mutating func scannerAndTokenizer(text: String?) throws -> JsonParserable {
        let inputString = try distinctNil(input: text)
        if inputString.first == Sign.frontSquareBracket, inputString.last == Sign.backSquareBracket {
            return buildArray(inputString: inputString) as! JsonParserable
        } else if inputString.first == Sign.frontCurlyBracket, inputString.last == Sign.backCurlyBracket {
            return buildDictionary(inputString: inputString) as! JsonParserable
        } else {
            throw ErrorMessage.notArray
        }
    }

}
