/*

JSON step2
 
 분석할 JSON 데이터를 입력하세요.
 { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true }
 총 4개의 객체 데이터 중에 문자열 2개, 숫자 1개, 부울 1개가 포함되어 있습니다.
 
 분석할 JSON 데이터를 입력하세요.
 [ { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true },
 { "name" : "YOON JISU", "alias" : "crong", "level" : 4, "married" : true } ]
 총 2개의 배열 데이터 중에 객체 2개가 포함되어 있습니다.
 
 어휘추가 '{', "}', ':'
 토큰추가 JSONArray, JSONObject
 
 key value로 값을 저장
 key는 쌍따옴표로 이루어진 문자열 value는 문자열, 숫자, 부울
 [ {}, {} ]
 
어휘 : 왼쪽대괄호, 오른쪽 대괄호, 쌍따옴표 왼쪽, 쌍따옴표 오른쪽, 콤마, 띄어쓰기
토큰 : string, number, bool, array

 */
import Foundation

enum Token{
    case string(value:String)
    case number(value:Double)
    case bool(value:Bool)
    case JSONArray(tokens:[Token])
    
        func value() -> [Token]{
            switch self {
            case .JSONArray(let tokens):
                return tokens
            case .number, .bool, .string:
                return [self]
        }
    }
}

struct JSONLexer {
    
    enum Error:Swift.Error {
        case invalidFormatLex
        case invalidFormatBracket
        case invalidFormatDoubleQuote
        case invalidFormatNumber
        case invalidFormatBool
        case invalidFormatGetDouble
    }
    
    private let input:String
    private var position: String.Index
    
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
    
    mutating func lex() throws -> Token{
        var token:Token = Token.JSONArray(tokens: [])
        
        while let nextCharacter = peek(){
            // '[' 로 시작해야한다.
            switch nextCharacter {
            case " ": advance()
            case "[": try token = bracket()
            case "]" where position == input.index(before: input.endIndex) :
                return token
            default: throw JSONLexer.Error.invalidFormatLex
            }
        }
        throw JSONLexer.Error.invalidFormatLex
    }
    
    private mutating func bracket() throws -> Token {
        var token:Token = Token.JSONArray(tokens: [])
        // bracket이면 다음 거
        advance()
        
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0" ... "9":
                let value = try getNumber()
                token = try appendToken(token, value)
                
            // 공백과 콤마는 다음으로
            case " ", ",": advance()
            case "\"":
                advance()
                let value = try doubleQuote()
                token = try appendToken(token, value)
                
            case "t", "T", "f","F":
                let value = try getBool()
                token = try appendToken(token, value)
                
            case "]" where position == input.index(before: input.endIndex) :
                return token
            default: throw JSONLexer.Error.invalidFormatBracket
            }
        }
        throw JSONLexer.Error.invalidFormatBracket
    }
    
    private func appendToken(_ token:Token, _ value:Any) throws -> Token {
        switch token {
        case .JSONArray(var tokens):
            if value is Double {
                tokens.append(.number(value:value as! Double))
            } else if value is String {
                tokens.append(.string(value:value as! String))
            } else if value is Bool {
                tokens.append(.bool(value: value as! Bool))
            } else {
                throw JSONLexer.Error.invalidFormatBracket
            }
            return Token.JSONArray(tokens: tokens)
        default: throw JSONLexer.Error.invalidFormatBracket
            
        }
    }
    
    private mutating func doubleQuote() throws -> String {
        var value = ""
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "a"..."z", "0"..."9", "A"..."Z", ".":
                value.append(nextCharacter)
                advance()
            case "\"":
                advance()
                return value
            default: throw JSONLexer.Error.invalidFormatDoubleQuote
            }
        }
        throw JSONLexer.Error.invalidFormatDoubleQuote
    }
    
   private mutating func getBool() throws -> Bool {
        var value:Bool = false
        var rawValue:String = ""
        
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "t", "T", "f","F", "a", "A", "l", "L", "s", "S", "e", "E", "r", "R", "u", "U":
                rawValue.append(nextCharacter)
                advance()
            case ",", " ":
                value = try checkBool(rawValue)
                return value
            case "]" where position == input.index(before: input.endIndex):
                value = try checkBool(rawValue)
                return value
            default: throw JSONLexer.Error.invalidFormatBool
            }
        }
        throw JSONLexer.Error.invalidFormatBool
    }
    
    private func checkBool(_ rawValue:String) throws -> Bool{
        guard let value = rawValue.toBool() else {
            throw JSONLexer.Error.invalidFormatBool
        }
        return value
    }
    
    private mutating func getNumber() throws -> Double {
        var value = 0.0
        
        while let nextChracter = peek() {
            switch nextChracter {
            case "0" ... "9":
                let digitValue = Double(String(nextChracter))!
                value = 10 * value + digitValue
                advance()
            case ",", " ":
                advance()
                return value
            case ".":
                let valueWithDot = String(value)
                advance()
                value = try getDouble(valueWithDot)
            case "]" where position == input.index(before: input.endIndex) :
                return value
            default: throw JSONLexer.Error.invalidFormatNumber
            }
        }
        throw JSONLexer.Error.invalidFormatNumber
    }
    
    private mutating func getDouble(_ number : String) throws -> Double {
        var value = number
        
        while let nextChracter = peek() {
            switch nextChracter {
            case "0" ... "9":
                value.append(nextChracter)
                advance()
            case ",", " ":
                advance()
                return try valueToDouble(value)
            case "]" where position == input.index(before: input.endIndex) :
                return try valueToDouble(value)
            default: throw JSONLexer.Error.invalidFormatGetDouble
            }
        }
        throw JSONLexer.Error.invalidFormatGetDouble
    }
    
    private func valueToDouble(_ rawValue : String ) throws -> Double {
        guard let value = Double(rawValue) else {
            throw JSONLexer.Error.invalidFormatGetDouble
        }
        return value
    }
}

