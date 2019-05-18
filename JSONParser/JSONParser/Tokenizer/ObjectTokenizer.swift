import Foundation

struct ObjectTokenizer {
    
    enum TokenizingError: Error {
        case cannotDetectBeginOrEndOfObject
        case objectKeyShouldBeOneAndOnly
    }
    
    static func tokenize(_ input: String) throws -> [String: String] {
        
        guard input.first == Token.beginObject, input.last == Token.endObject else {
            throw TokenizingError.cannotDetectBeginOrEndOfObject
        }
        var input = input
        input.removeFirst()
        input.removeLast()
        
        var tokenized = [String: String]()
        var keyBuffer = ""
        var valueBuffer = ""
        var isParsingString = false
        var nestedArrayCount: UInt = 0
        var nestedObjectCount: UInt = 0
        var isParsingKey = true
        
        for character in input {
            if character == Token.quotationMark {
                isParsingString.toggle()
            } else {
                guard !isParsingString else { break }
                switch character {
                case Token.endObject:
                    nestedObjectCount -= 1
                case Token.beginObject:
                    nestedObjectCount += 1
                case Token.endArray:
                    nestedArrayCount -= 1
                case Token.beginArray:
                    nestedArrayCount += 1
                case Token.valueSeparator:
                    guard nestedObjectCount == 0, nestedArrayCount == 0 else {
                        break
                    }
                    try move(fromKeyBuffer: &keyBuffer, valueBuffer: &valueBuffer, to: &tokenized)
                    isParsingKey = true
                    continue
                case Token.nameSeparator:
                    isParsingKey = false
                    continue
                default:
                    break
                }
            }
            if isParsingKey {
                keyBuffer.append(character)
            } else {
                valueBuffer.append(character)
            }
        }
        try move(fromKeyBuffer: &keyBuffer, valueBuffer: &valueBuffer, to: &tokenized)
        return tokenized
    }
    
    private static func move(fromKeyBuffer keyBuffer: inout String, valueBuffer: inout String, to result: inout [String: String]) throws {
        
        let key = keyBuffer.trimmingCharacters(in: Token.whitespace)
        let value = valueBuffer.trimmingCharacters(in: Token.whitespace)
        guard result[key] == nil else {
            throw TokenizingError.objectKeyShouldBeOneAndOnly
        }
        result[key] = value
        keyBuffer.removeAll()
        valueBuffer.removeAll()
    }
    
}
