/*

// TODO:- JSON step4 피드백 1
bracket(), curlyBrace() 내부에서 정규식을 써서 처리하도록 변경해보세요.

 
 */
import Foundation

func ~=<T:Equatable>(pattern:[T], value:T) -> Bool {
    return pattern.contains(value)
}

typealias JSONObject = Dictionary<String, Token>

enum Token:TokenBasicValueable {
    case number(value:Double)
    case string(value:String)
    case bool(value:Bool)
    case jsonArray(tokens:[Token])
    case jsonObject(JSONObject)
    
    func getToken() -> Token {
        return self
    }
}

struct JSONLexer {
    
    enum Error:Swift.Error {
        case invalidFormatLex
        case invalidFormatBracket
        case invalidFormatCurlyBrace
    }
    
    private var input:String
    private var position: String.Index
    private let blank:Character = " "
    private let comma:Character = ","
    private let openBracket:Character = "["
    private let closeBracket:Character = "]"
    private let openCurlyBrace:Character = "{"
    private let closeCurlyBrace:Character = "}"
    
    init(input:String) {
        self.input = input
        self.position = self.input.startIndex
    }
    
    private func peek() -> Character? {
        return position < input.endIndex ? input[position] : nil
    }
    
    private mutating func advance() {
        guard position < input.endIndex else {
            return
        }
        position = input.index(after: position)
    }
    
    mutating func lex() throws -> Token {
        var token:Token = Token.jsonArray(tokens: [])
        
        while let nextCharacter = peek(){
            switch nextCharacter {
            case blank, comma : advance()
            case openBracket : try token = bracket()
            case openCurlyBrace : try token = curlyBrace()
            // 끝이 아닐 때
            case closeBracket : return token
            case closeBracket where position == input.index(before: input.endIndex), closeCurlyBrace where position == input.index(before: input.endIndex) :
                return token
            default: throw JSONLexer.Error.invalidFormatLex
            }
        }
        throw JSONLexer.Error.invalidFormatLex
    }
    
    private mutating func curlyBrace() throws -> Token {
        var token:Token = Token.jsonObject([:])
        
        let nestedObjectRegex = try NSRegularExpression(pattern: JSONPatterns.nestedObjectPattern)
        let objectRegex = try NSRegularExpression(pattern:JSONPatterns.objectPattern)
        let arrayRegex = try NSRegularExpression(pattern: JSONPatterns.arrayPattern)

        if let objectFirstMatch = objectRegex.firstMatch(in: input, options: [], range: NSRange(location: 0, length: input.count)) {
            if input == input[objectFirstMatch.range] {
              token = try innerCurlyBrace()
              position = input.index(before: input.endIndex)
              return token
            }
        }
        
        if let nestedObjectFirstMatch = nestedObjectRegex.firstMatch(in: input, options: [], range: NSRange(location: 0, length: input.count)) {
                let valuesInNestedObject = input[nestedObjectFirstMatch.range]
            
                let values = try matches(for: "\\s*\(JSONPatterns.stringPattern)\\s*:\\s*(\(JSONPatterns.stringPattern)|\(JSONPatterns.boolPattern)|\(JSONPatterns.arrayPattern)|\(JSONPatterns.numberPattern))", in: valuesInNestedObject)
            
                var key = ""
                var tokenValue = ""
            
                for value in values {
                    
                    let splitedInKeyValue = value.split(separator: ":")
                    key = splitedInKeyValue[0].trimmingCharacters(in: .whitespaces)
                    tokenValue = splitedInKeyValue[1].trimmingCharacters(in: .whitespaces)

                    if let _ = arrayRegex.firstMatch(in: tokenValue, options: [], range: NSRange(location: 0, length: tokenValue.count)) {
                        input = tokenValue.trimmingCharacters(in: .whitespaces)
                        let arrayToken = try innerBracket()
                        token = try appendTokenToJSONObject(token, key, arrayToken)
                        continue
                    }
                    
                    
                    if let numberValue = Double(tokenValue) {
                        token = try appendTokenToJSONObject(token, key, numberValue)
                        continue
                    }
                    if let boolValue = Bool(tokenValue) {
                        token = try appendTokenToJSONObject(token, key, boolValue)
                        continue
                    }
                    token = try appendTokenToJSONObject(token, key, tokenValue)
            }
        } else{
            throw JSONLexer.Error.invalidFormatBracket
        }

        position = input.index(before: input.endIndex)
        return token
    }
    
    private mutating func innerCurlyBrace() throws -> Token {
        var token:Token = Token.jsonObject([:])
        let objectRegex = try NSRegularExpression(pattern:JSONPatterns.objectPattern)
        
        if let objectFirstMatch = objectRegex.firstMatch(in: input, options: [], range: NSRange(location: 0, length: input.count)) {
            let valuesInObject = input[objectFirstMatch.range]
            let values = try matches(for: "\\s*\(JSONPatterns.stringPattern)\\s*:\\s*(\(JSONPatterns.stringPattern)|\(JSONPatterns.boolPattern)|\(JSONPatterns.numberPattern))", in: valuesInObject)
    
            var key = ""
            var tokenValue = ""
    
    
            for value in values {
                let splitedInKeyValue = value.split(separator: ":")
                key = splitedInKeyValue[0].trimmingCharacters(in: .whitespaces)
                tokenValue = splitedInKeyValue[1].trimmingCharacters(in: .whitespaces)
                if let numberValue = Double(tokenValue) {
                    token = try appendTokenToJSONObject(token, key, numberValue)
                    continue
                }
                if let boolValue = Bool(tokenValue) {
                    token = try appendTokenToJSONObject(token, key, boolValue)
                    continue
                }
                token = try appendTokenToJSONObject(token, key, tokenValue)
            }
        } else {
            throw JSONLexer.Error.invalidFormatCurlyBrace
        }
        
        position = input.index(before: input.endIndex)
        return token
    }
    
    private func appendTokenToJSONObject(_ token:Token, _ key:String, _ value:TokenBasicValueable) throws -> Token {
        switch token {
        case .jsonObject(var objects):
            objects[key] = value.getToken()
            return .jsonObject(objects)
        default: throw JSONLexer.Error.invalidFormatCurlyBrace
        }
    }
    
    private func matches(for pattern: String, in text:String) throws -> [String] {
        let regex = try NSRegularExpression(pattern: pattern, options: [])
        let results = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
        return results.map { String(text[Range($0.range, in: text)!]) }
    }
    
    private mutating func bracket() throws -> Token {
        var token:Token = Token.jsonArray(tokens: [])
        
        let nestedArrayRegex = try NSRegularExpression(pattern:JSONPatterns.nestedArrayPattern)
        let arrayRegex = try NSRegularExpression(pattern: JSONPatterns.arrayPattern)

        

        if let arrayFirstMatch = arrayRegex.firstMatch(in: input, options: [], range: NSRange(location: 0, length: input.count)) {
            // 매치 된 게 원래 거랑 같으면
            if input == input[arrayFirstMatch.range] {
                token = try innerBracket()
                position = input.index(before: input.endIndex)
                return token
            }
        }
        
        if let nestedArrayFisrtMatch = nestedArrayRegex.firstMatch(in: input, options: [], range: NSRange(location: 0, length: input.count)) {
            let valuesInNestedArray = input[nestedArrayFisrtMatch.range]
            
            let values = try matches(for: "(\(JSONPatterns.objectPattern)|\(JSONPatterns.arrayPattern)|\(JSONPatterns.stringPattern)|\(JSONPatterns.numberPattern)|\(JSONPatterns.boolPattern))", in: valuesInNestedArray)
            
            for value in values {
                
                let objectRegex = try NSRegularExpression(pattern: JSONPatterns.objectPattern)
                
                if let _ = objectRegex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) {
                    input = value.trimmingCharacters(in: .whitespaces)
                    token = try appendTokenToJSONArray(token, curlyBrace())
                    continue
                }
                
                if let _ = arrayRegex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) {
                    input = value.trimmingCharacters(in: .whitespaces)
                    token = try appendTokenToJSONArray(token, innerBracket())
                    continue
                }
                
                if let numberValue = Double(value) {
                    token = try appendTokenToJSONArray(token, numberValue)
                    continue
                }
                
                if let boolValue = Bool(value) {
                    token = try appendTokenToJSONArray(token, boolValue)
                    continue
                }
                
                // string
                token = try appendTokenToJSONArray(token, value)
            }
        } else {
            throw JSONLexer.Error.invalidFormatBracket
        }
        position = input.index(before: input.endIndex)
        return token
    }
    
    private mutating func innerBracket() throws -> Token {
        var token:Token = Token.jsonArray(tokens: [])

        let arrayRegex = try NSRegularExpression(pattern:JSONPatterns.arrayPattern)
        if let firstMatch = arrayRegex.firstMatch(in: input, options: [], range: NSRange(location: 0, length: input.count)) {
            // [(number|bool|string|object),(number|bool|string|object)] -> (number|bool|string|object),(number|bool|string|object)
            let valuesInArray = input[firstMatch.range]
            
            
            let values = try matches(for: "(\(JSONPatterns.objectPattern)|\(JSONPatterns.stringPattern)|\(JSONPatterns.numberPattern)|\(JSONPatterns.boolPattern))", in: valuesInArray)
            
            for value in values {
                
                let objectRegex = try NSRegularExpression(pattern: JSONPatterns.objectPattern)
                
                if let _ = objectRegex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) {
                    input = value
                    token = try appendTokenToJSONArray(token, curlyBrace())
                    continue
                }
                
                if let numberValue = Double(value) {
                    token = try appendTokenToJSONArray(token, numberValue)
                    continue
                }
                
                if let boolValue = Bool(value) {
                    token = try appendTokenToJSONArray(token, boolValue)
                    continue
                }
                
                // string
                token = try appendTokenToJSONArray(token, value)
                
            }
        } else {
            throw JSONLexer.Error.invalidFormatBracket
        }
        position = input.index(before: input.endIndex)
        return token
    }
    
    private func appendTokenToJSONArray(_ token:Token, _ value:TokenBasicValueable) throws -> Token {
        switch token {
        case .jsonArray(var tokens):
            tokens.append(value.getToken())
            return .jsonArray(tokens: tokens)
        default: throw JSONLexer.Error.invalidFormatBracket
            
        }
    }
}

