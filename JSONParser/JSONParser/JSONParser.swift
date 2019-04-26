import Foundation

struct JSONParser {
    
    var data = Data()
    
    
    
    
    
    
    
    struct StringParser {
        var buffer = ""
        var isDataToParse = false
        var isEscapeSequence = false
        
        mutating func parse(character: Character) -> String? {
            switch character {
            case "\\":
                if isEscapeSequence {
                    buffer.append(character)
                } else {
                    isEscapeSequence = !isEscapeSequence
                }
            case "\"":
                if isEscapeSequence {
                    buffer.append(character)
                    isEscapeSequence = !isEscapeSequence
                } else {
                    isDataToParse = !isDataToParse
                }
            default:
                if isDataToParse {
                    buffer.append(character)
                } else {
                    return buffer
                }
            }
            return nil
        }
    }
    
    
    
    struct NumberParser {
        var buffer = ""
        var isDataToParse = false
        var hasMinusSign = false
        var isZero = false
        
        mutating func parse(character: Character) throws -> Double? {
            switch character {
            case "-":
                if hasMinusSign {
                    throw NumberParserError.duplicatedMinusSign
                } else {
                    hasMinusSign = !hasMinusSign
                    buffer.append(character)
                }
            case "0":
                if isZero {
                    throw NumberParserError.duplicatedNumberZero
                } else {
                    isZero = !isZero
                }
            default:
                buffer.append(character)
            }
            
            return nil
        }
        
    }
    
    
}

enum NumberParserError: Error {
    case duplicatedMinusSign
    case duplicatedNumberZero
    case invalidNumber
}
