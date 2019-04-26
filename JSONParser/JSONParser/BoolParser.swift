import Foundation

struct BoolParser: Parser {
    
    var result: SupportedType
    var didDetermineBoolValue = false
    
    var trueCharacters: [Character] = ["t", "r", "u", "e"]
    var falseCharacters: [Character] = ["f", "a", "l", "s", "e"]

    mutating func parse(_ character: Character) throws -> Bool {
        switch character {
        case trueCharacters.first:
            if didDetermineBoolValue {
                if result as! Bool {
                    trueCharacters.removeFirst()
                } else {
                    throw BoolParsingError.cannotFindBoolFormat
                }
            } else {
                result = true
            }
            return true
        case falseCharacters.first:
            if didDetermineBoolValue {
                if !(result as! Bool) {
                    falseCharacters.removeFirst()
                } else {
                    throw BoolParsingError.cannotFindBoolFormat
                }
            } else {
                result = false
            }
            return true
        case ",", " ":
            return false
        default:
            throw BoolParsingError.cannotFindBoolFormat
        }
    }
    
    
    
    
}

enum BoolParsingError: Error {
    case cannotFindBoolFormat
}
