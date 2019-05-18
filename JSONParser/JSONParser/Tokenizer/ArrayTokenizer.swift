import Foundation

struct ArrayTokenizer {
    
    enum TokenizingError: Error {
        case cannotDetectBeginOrEndOfArray
        case invalidNestedStructure
        case invalidArrayGrammar
        case bufferIsEmpty
    }
    
    static func tokenize(_ input: String) throws -> [String] {
        
        guard input.first == Token.beginArray, input.last == Token.endArray else {
            throw TokenizingError.cannotDetectBeginOrEndOfArray
        }
        var input = input
        input.removeFirst()
        input.removeLast()
        
        var tokenizedInput = [String]()
        var buffer = ""
        var isParsingString = false
        var nestedArrayCount: UInt = 0
        var nestedObjectCount: UInt = 0
        
        for character in input {
            if character == Token.quotationMark {
                isParsingString.toggle()
            } else if !isParsingString {
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
                    try move(fromBuffer: &buffer, to: &tokenizedInput)
                    continue
                default:
                    break
                }
            }
            buffer.append(character)
        }
        guard !buffer.isEmpty else {
            return tokenizedInput
        }
        try move(fromBuffer: &buffer, to: &tokenizedInput)
        return tokenizedInput
    }
    
    private static func move(fromBuffer buffer: inout String, to result: inout [String]) throws {
        guard !buffer.isEmpty else {
            throw TokenizingError.bufferIsEmpty
        }
        result.append(buffer.trimmingCharacters(in: Token.whitespace))
        buffer.removeAll()
    }
    
    
}




