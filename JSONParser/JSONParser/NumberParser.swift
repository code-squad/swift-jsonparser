import Foundation

struct NumberParser: Parser {
    var buffer = ""
    var isDataToParse = false
    var hasMinusSign = false
    var isZero = false
    
    mutating func parse(character: Character) throws -> Double? {
        switch character {
        case "-":
            if hasMinusSign {
                throw NumberParsingError.duplicatedMinusSign
            } else {
                hasMinusSign = !hasMinusSign
                buffer.append(character)
            }
        case "0":
            if isZero {
                throw NumberParsingError.duplicatedNumberZero
            } else {
                isZero = !isZero
            }
        default:
            buffer.append(character)
        }
        
        return nil
    }
    
}

enum NumberParsingError: Error {
    case duplicatedMinusSign
    case duplicatedNumberZero
    case invalidNumber
}
