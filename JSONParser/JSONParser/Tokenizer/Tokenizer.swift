import Foundation

struct Tokenizer {
    
    enum TokenizingError: Error {
        case cannotDetectBeginOrEndOfArray
        case invalidNestedStructure
        case invalidArrayGrammar
        case bufferIsEmpty
    }
    
    static func arrayTokenize(input: String) throws -> [String] {
        guard FormatValidator.validateArrayFormat(input)
    }
    
    private static func separateValues(input: String) throws -> [String] {
        
        let input = input.trimmingCharacters(in: Token.whitespace)
        
        if input == "" { return [] }
        
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
        
        for character in input {
            if character == Token.quotationMark {
                isParsingString.toggle()
            } else if !isParsingString {
                try parse(character: character)
            }
            buffer.append(character)
        }
        try moveBufferToResult()
        return result
    }
    
    
    
}




