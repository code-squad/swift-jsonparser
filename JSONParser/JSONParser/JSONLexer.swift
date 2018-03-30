/*
컴파일러 1단계 어휘 분석
어휘분석은 정해 놓은 어휘(lexicon)에 따라, 문자열을 token으로 나누는 행위
JSON step1단계 같은 경우에는
어휘 : 왼쪽대괄호, 오른쪽 대괄호, 쌍따옴표 왼쪽, 쌍따옴표 오른쪽, 콤마, 띄어쓰기
토큰 : string, number, bool
 
[ 10, "jk", 4, "314", 9.9, "crong", false ]
 */
import Foundation

enum Token{
    case string(value:String)
    case number(value:Double)
    case bool(value:Bool)
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
    
    mutating func lex() throws -> [Token] {
        var tokens = [Token]()
        while let nextCharacter = peek(){
            // '[' 로 시작해야한다.
            switch nextCharacter {
            case " ": advance()
            case "[": try tokens = bracket()
            case "]" where position == input.index(before: input.endIndex) :
                return tokens
            default: throw JSONLexer.Error.invalidFormatLex
            }
        }
        throw JSONLexer.Error.invalidFormatLex
    }
    
    private mutating func bracket() throws -> [Token] {
        var tokens = [Token]()
        // bracket이면 다음 거
        advance()
        
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0" ... "9":
                let value = try getNumber()
                tokens.append(.number(value: value))
            // 공백과 콤마는 다음으로
            case " ", ",": advance()
            case "\"":
                advance()
                let value = try doubleQuote()
                tokens.append(.string(value: value))
            case "t", "T", "f","F":
                let value = try getBool()
                tokens.append(.bool(value: value))
            case "]" where position == input.index(before: input.endIndex) :
                return tokens
            default: throw JSONLexer.Error.invalidFormatBracket
            }
        }
        throw JSONLexer.Error.invalidFormatBracket
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
