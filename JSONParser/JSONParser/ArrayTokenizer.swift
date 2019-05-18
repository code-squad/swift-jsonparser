import Foundation

struct ArrayTokenizer {
    
    enum TokenizingError: Error {
        case cannotDetectBeginOrEndOfArray
    }
    
    static func tokenize(_ input: String) throws -> [String] {
        
        guard input.first == Token.beginArray, input.last == Token.endArray else {
            throw TokenizingError.cannotDetectBeginOrEndOfArray
        }
        var input = input
        input.removeFirst()
        input.removeLast()
        
        var tokenized = [String]()
        var buffer = ""
        var isParsingString = false
        var nestedArrayCount: UInt = 0
        
        for character in input {
            switch character {
            case Token.quotationMark:
                isParsingString.toggle()
            case Token.endArray:
                guard !isParsingString else { break }
                nestedArrayCount -= 1
            case Token.beginArray:
                guard !isParsingString else { break }
                nestedArrayCount += 1
            case Token.valueSeparator:
                guard !isParsingString, nestedArrayCount == 0 else { break }
                appendFromBuffer(&tokenized, &buffer)
                continue
            default:
                break
            }
            buffer.append(character)
        }
        appendFromBuffer(&tokenized, &buffer)
        return tokenized
    }
    
    private static func appendFromBuffer(_ tokenized: inout [String], _ buffer: inout String) {
        tokenized.append(buffer.trimmingCharacters(in: Token.whitespace))
        buffer = ""
    }
    
    
}




