import Foundation

struct StringParser: Parser {
    var buffer = ""
    var isDataToParse = false
    var isEscapeSequence = false
    
    mutating func parse(character: Character) {
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
