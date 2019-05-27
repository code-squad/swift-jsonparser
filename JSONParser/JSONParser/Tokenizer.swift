//
//  Tokenizer.swift
//  JSONParser
//
//  Created by jang gukjin on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Tokenizer {
    func buildArray(string:String) -> [String] {
        var json: [String] = []
        var array: [String] = []
        var dictionaryCount = 0
        var stringCountr = 0
        var arrayCount = 0
        var sample = string
        sample.removeLast()
        sample.removeFirst()
        for i in sample.indices {
            if sample[i] == Sign.frontCurlyBracket {
                dictionaryCount += 1
            } else if stringCountr == 0, sample[i] == Sign.doubleQuote {
                stringCountr += 1
            } else if sample[i] == Sign.frontSquareBracket {
                arrayCount += 1
            } else if dictionaryCount > 0, sample[i] == Sign.backSquareBracket {
                dictionaryCount -= 1
            } else if stringCountr > 0, sample[i] == Sign.doubleQuote {
                stringCountr -= 1
            } else if arrayCount > 0, sample[i] == Sign.backSquareBracket {
                arrayCount -= 1
            }
            array.append(String(sample[i]))
            if (dictionaryCount == 0 && stringCountr == 0 && arrayCount == 0) && (sample[i] == Sign.comma || i == sample.index(before: sample.endIndex)) {
                var input = array.joined()
                let inputDatum = input.trimmingCharacters(in: CharacterSet(charactersIn: "\(Sign.comma)"))
                input = inputDatum.trimmingCharacters(in: .whitespacesAndNewlines)
                array = []
                json.append(input)
            }
        }
        print("배열")
        return json
    }
    
    func buildDictionary(string: String) -> [String:String] {
        var json: [String] = []
        var dicjson = [String:String]()
        var array: [String] = []
        var dictionaryCount = 0
        var stringCount = 0
        var arrayCount = 0
        var sample = string
        sample.removeLast()
        sample.removeFirst()
        for i in sample.indices {
            if sample[i] == Sign.frontCurlyBracket {
                dictionaryCount += 1
            } else if stringCount == 0, sample[i] == Sign.doubleQuote {
                stringCount += 1
            } else if sample[i] == Sign.frontSquareBracket {
                arrayCount += 1
            } else if dictionaryCount > 0, sample[i] == Sign.backCurlyBracket {
                dictionaryCount -= 1
            } else if stringCount > 0, sample[i] == Sign.doubleQuote {
                stringCount -= 1
            } else if arrayCount > 0, sample[i] == Sign.backSquareBracket {
                arrayCount -= 1
            }
            array.append(String(sample[i]))
            if (dictionaryCount == 0 && stringCount == 0 && arrayCount == 0) && (sample[i] == Sign.comma || sample[i] == Sign.colon || i == sample.index(before: sample.endIndex)) {
                var input = array.joined()
                let inputDatum = input.trimmingCharacters(in: CharacterSet(charactersIn: "\(Sign.comma)"))
                input = inputDatum.trimmingCharacters(in: .whitespacesAndNewlines)
                array = []
                json.append(input)
            }
        }
        for j in 0..<json.count-1 {
            if j % 2 == 0, json[j].last == Sign.colon {
                json[j] = json[j].trimmingCharacters(in: CharacterSet(charactersIn: "\(Sign.colon)"))
                json[j] = json[j].trimmingCharacters(in: .whitespacesAndNewlines)
                dicjson[json[j]] = json[j+1]
            }
        }
        print("객체")
        return dicjson
    }
    
    func scanner(string: String){
        if string.first == Sign.frontSquareBracket, string.last == Sign.backSquareBracket {
            print("\(buildArray(string: string))")
        } else if string.first == Sign.frontCurlyBracket, string.last == Sign.backCurlyBracket {
            print("\(buildDictionary(string: string))")
        } else {
            print("잘못된 입력")
        }
    }

}
