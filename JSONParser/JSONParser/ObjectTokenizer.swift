import Foundation

struct ObjectTokenizer {
    
    enum TokenizingError: Error {
        case cannotDetectBeginOrEndOfObject
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
        var nestedObjectCount: UInt = 0
        var isParsingKey = true
        
        for character in input {
            switch character {
            case Token.quotationMark:
                isParsingString.toggle()
            case Token.endObject:
                guard !isParsingString else { break }
                nestedObjectCount -= 1
            case Token.beginObject:
                guard !isParsingString else { break }
                nestedObjectCount += 1
            case Token.valueSeparator:
                guard !isParsingString, nestedObjectCount == 0 else { break }
                append(fromKeyBuffer: &keyBuffer, valueBuffer: &valueBuffer, to: &tokenized)
                isParsingKey = true
                continue
            case Token.nameSeparator:
                isParsingKey = false
                continue
            default:
                break
            }
            if isParsingKey {
                keyBuffer.append(character)
            } else {
                valueBuffer.append(character)
            }
            
        }
        append(fromKeyBuffer: &keyBuffer, valueBuffer: &valueBuffer, to: &tokenized)
        return tokenized
    }
    
    private static func append(fromKeyBuffer keyBuffer: inout String, valueBuffer: inout String, to result: inout [String: String]) {
        
        let key = keyBuffer.trimmingCharacters(in: Token.whitespace)
        let value = valueBuffer.trimmingCharacters(in: Token.whitespace)
        
        result[key] = value
        
        keyBuffer.removeAll()
        valueBuffer.removeAll()
    }
    
}
