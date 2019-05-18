import Foundation

struct ArrayTokenizer {
    
    enum TokenizingError: Error {
        case cannotDetectBeginOrEndOfArray
    }
    
    private func tokenize(_ input: String) throws -> [String] {
        
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
                guard !isParsingString else { continue }
                nestedArrayCount -= 1
            case Token.beginArray:
                guard !isParsingString else { continue }
                nestedArrayCount += 1
            case Token.valueSeparator:
                tokenized.append(buffer)
                buffer = ""
            default:
                buffer.append(character)
            }
        }
        
    }
    
    
}




