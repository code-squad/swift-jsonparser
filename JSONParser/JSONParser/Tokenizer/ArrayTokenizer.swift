import Foundation

struct ArrayTokenizer {
    
    enum TokenizingError: Error {
        case cannotDetectBeginOrEndOfArray
        case invalidNestedStructure
        case invalidArrayGrammar
        case bufferIsEmpty
    }
    
    /// 처음과 끝의 괄호가 제거된 후에 사용해야 함.
    static func tokenize(_ input: String) throws -> [String] {
        
        var input = input
        input.removeFirst()
        input.removeLast()
        let values = input.trimmingCharacters(in: Token.whitespace)
        
        guard FormatValidator.validateArrayFormat(values) else {
            throw TokenizingError.invalidArrayGrammar
        }
        
        var result = [String]()
        var buffer = ""
        var isParsingString = false
        var nestedArrayCount: UInt = 0
        var nestedObjectCount: UInt = 0
        
        func moveBufferToResult() throws {
            guard !buffer.isEmpty else {
                throw TokenizingError.bufferIsEmpty
            }
            result.append(buffer.trimmingCharacters(in: Token.whitespace))
            buffer.removeAll()
        }
        
        func parse(character: Character) throws {
            switch character {
            case Token.endArray:
                guard nestedArrayCount > 0 else {
                    throw TokenizingError.invalidNestedStructure
                }
                nestedArrayCount -= 1
            case Token.beginArray:
                nestedArrayCount += 1
            case Token.endObject:
                guard nestedObjectCount > 0 else {
                    throw TokenizingError.invalidNestedStructure
                }
                nestedObjectCount -= 1
            case Token.beginObject:
                nestedObjectCount += 1
            case Token.valueSeparator:
                guard nestedArrayCount == 0, nestedObjectCount == 0 else { break }
                try moveBufferToResult()
                return
            default:
                break
            }
        }
        
        for character in values {
            if character == Token.quotationMark {
                isParsingString.toggle()
            } else if !isParsingString {
                try parse(character: character)
            }
            buffer.append(character)
        }
        guard !buffer.isEmpty else {
            return result
        }
        try moveBufferToResult()
        return result
    }
    
    
    
}




