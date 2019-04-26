import Foundation

struct BoolParser: Parser {
    
    private(set) var result: SupportedType
    private var didDetermineBoolValue = false
    
    private var trueCharacters: [Character] = ["t", "r", "u", "e"]
    private var falseCharacters: [Character] = ["f", "a", "l", "s", "e"]
    
    mutating func parse(_ character: Character) throws -> Bool {
        switch character {
        case trueCharacters.first:
            if didDetermineBoolValue {
                throw BoolParsingError.cannotFindBoolFormat
            } else {
                result = true
                falseCharacters.removeAll()
            }
            return true
        case falseCharacters.first:
            if didDetermineBoolValue {
                throw BoolParsingError.cannotFindBoolFormat
            } else {
                result = false
                trueCharacters.removeAll()
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
