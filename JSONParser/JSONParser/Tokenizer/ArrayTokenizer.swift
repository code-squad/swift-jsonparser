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
        var nestedObjectCount: UInt = 0
        
        for character in input {
            if character == Token.quotationMark {
                isParsingString.toggle()
            } else {
                guard !isParsingString else { break }
                switch character {
                case Token.endArray:
                    nestedArrayCount -= 1
                case Token.beginArray:
                    nestedArrayCount += 1
                case Token.endObject:
                    nestedObjectCount -= 1
                case Token.beginObject:
                    nestedObjectCount += 1
                case Token.valueSeparator:
                    guard nestedArrayCount == 0, nestedObjectCount == 0 else { break }
                    move(fromBuffer: &buffer, to: &tokenized)
                    continue
                default:
                    break
                }
                
            }
            buffer.append(character)
        }
        move(fromBuffer: &buffer, to: &tokenized)
        return tokenized
    }
    
    private static func move(fromBuffer buffer: inout String, to result: inout [String]) {
        result.append(buffer.trimmingCharacters(in: Token.whitespace))
        buffer.removeAll()
    }
    
    
}




