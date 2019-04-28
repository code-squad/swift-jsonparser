import Foundation

struct BoolParser: Parser {
    
    private static var resultBool = true
    private static var boolCharacters = [Character]()
    private static var didRunFirstParse = false
    
    static func parse(_ character: Character) throws -> SupportedType? {
        if didRunFirstParse {
            return try secondParse(character)
        } else {
            try firstParse(character)
            return nil
        }
    }
    
    private static func firstParse(_ character: Character) throws {
        switch character {
        case "t":
            resultBool = true
            boolCharacters = ["r", "u", "e"]
        case "f":
            resultBool = false
            boolCharacters = ["a", "l", "s", "e"]
        default:
            throw BoolParsingError.cannotFindBoolFormat
        }
    }
    
    private static func secondParse(_ character: Character) throws -> SupportedType? {
        if character == boolCharacters.first {
            boolCharacters.removeFirst()
            return nil
        }
        return resultBool
    }
    
    
}

enum BoolParsingError: Error {
    case cannotFindBoolFormat
}
