/*

JSON step2
 
 분석할 JSON 데이터를 입력하세요.
 { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true }
 총 4개의 객체 데이터 중에 문자열 2개, 숫자 1개, 부울 1개가 포함되어 있습니다.
 
 분석할 JSON 데이터를 입력하세요.
 [ { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true },
 { "name" : "YOON JISU", "alias" : "crong", "level" : 4, "married" : true } ]
 총 2개의 배열 데이터 중에 객체 2개가 포함되어 있습니다.
 
 어휘추가 '{', '}', ':'
 토큰추가 JSONObject
 
 key value로 값을 저장
 key는 쌍따옴표로 이루어진 문자열 value는 문자열, 숫자, 부울
 [ {}, {} ]
 
어휘 : 왼쪽대괄호, 오른쪽 대괄호, 쌍따옴표 왼쪽, 쌍따옴표 오른쪽, 콤마, 띄어쓰기
토큰 : string, number, bool, array

 */
import Foundation

typealias JSONObject = (key:String, value:Token)

enum Token{
    case string(value:String)
    case number(value:Double)
    case bool(value:Bool)
    case jsonArray(tokens:[Token])
    case jsonObject([JSONObject])
}


struct JSONLexer {
    
    enum Error:Swift.Error {
        case invalidFormatLex
        case invalidFormatBracket
        case invalidFormatCurlyBrace
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
        var token:Token = Token.jsonArray(tokens: [])
        
        while let nextCharacter = peek(){
            switch nextCharacter {
            case " ", ",": advance()
            case "[": try token = bracket()
            case "{": try token = curlyBrace()
            case "]" where position == input.index(before: input.endIndex), "}" where position == input.index(before: input.endIndex) :
                return token
            default: throw JSONLexer.Error.invalidFormatLex
            }
        }
        throw JSONLexer.Error.invalidFormatLex
    }
    
    private mutating func curlyBrace() throws -> Token {
        var token:Token = Token.jsonObject([])
        var tempkey:String = ""
        var tempValue:Any!
        var isKey = true
        advance()
        while let nextChracter = peek() {
            switch nextChracter {
            case " ": advance()
            case "\"" where isKey == true :
                advance()
                tempkey = try doubleQuote()
            case ":": // key 담기
                advance()
                isKey = false
            case "\"" where isKey == false :
                advance()
                tempValue = try doubleQuote()
                isKey = true
            case "0" ... "9":
                tempValue = try getNumber()
                isKey = true
            case "t", "T", "f", "F":
                tempValue = try getBool()
                isKey = true
            case ",":
                advance()
                token = try appendTokenToJSONObject(token, tempkey, tempValue)
            case "}":
                token = try appendTokenToJSONObject(token, tempkey, tempValue)
                return token
            default: throw JSONLexer.Error.invalidFormatCurlyBrace
            }
        }
       throw JSONLexer.Error.invalidFormatCurlyBrace
    }
    
    private func appendTokenToJSONObject(_ token:Token, _ key:String, _ value:Any) throws -> Token {
        switch token {
        case .jsonObject(var objects):
            if value is Double {
                objects.append((key, .number(value: value as! Double)))
            } else if value is String {
                objects.append((key, .string(value: value as! String)))
            } else if value is Bool {
                objects.append((key, .bool(value: value as! Bool)))
            } else {
                throw JSONLexer.Error.invalidFormatCurlyBrace
            }
            return Token.jsonObject(objects)
        default: throw JSONLexer.Error.invalidFormatCurlyBrace
        }
    }
    
    private mutating func bracket() throws -> Token {
        var token:Token = Token.jsonArray(tokens: [])
        // bracket이면 다음 거
        advance()
        
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0" ... "9":
                let value = try getNumber()
                token = try appendTokenToJSONArray(token, value)
                
            // 공백과 콤마는 다음으로
            case " ", ",", "}": advance()
            case "\"":
                advance()
                let value = try doubleQuote()
                token = try appendTokenToJSONArray(token, value)
                
            case "t", "T", "f","F":
                let value = try getBool()
                token = try appendTokenToJSONArray(token, value)
            case "{" :
                let objectToken = try curlyBrace()
                token = try appendTokenToJSONArray(token, objectToken)
            case "]" where position == input.index(before: input.endIndex) :
                return token
            default: throw JSONLexer.Error.invalidFormatBracket
            }
        }
        throw JSONLexer.Error.invalidFormatBracket
    }
    
    private func appendTokenToJSONArray(_ token:Token, _ value:Any) throws -> Token {
        switch token {
        case .jsonArray(var tokens):
            if value is Double {
                tokens.append(.number(value:value as! Double))
            } else if value is String {
                tokens.append(.string(value:value as! String))
            } else if value is Bool {
                tokens.append(.bool(value: value as! Bool))
            } else if value is Token {
                
                var jsonObjects:[JSONObject] = []
                jsonObjects =  try getJsonObjects(value)
                tokens.append(.jsonObject(jsonObjects))
        
            } else {
                throw JSONLexer.Error.invalidFormatBracket
            }
            return Token.jsonArray(tokens: tokens)
        default: throw JSONLexer.Error.invalidFormatBracket
            
        }
    }
    
    private func getJsonObjects(_ value:Any) throws -> [JSONObject]{
        guard let token = value as? Token else {
            throw JSONLexer.Error.invalidFormatBracket
        }
        var tempjsonObjects:[JSONObject] = []
        switch token {
        case .jsonObject(let jsonObjects):
            for jsonObject in jsonObjects {
                tempjsonObjects.append(jsonObject)
            }
            return tempjsonObjects
        default:
            throw JSONLexer.Error.invalidFormatBracket
        }

    }
    
    private mutating func doubleQuote() throws -> String {
        var value = ""
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "a"..."z", "0"..."9", "A"..."Z", ".", " ":
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
            case " ":
                advance()
            case ",", "}":
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
                return value
            case ".":
                let valueWithDot = String(value)
                advance()
                value = try getDouble(valueWithDot)
            case "]" where position == input.index(before: input.endIndex) ,"}" where position == input.index(before: input.endIndex) :
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

