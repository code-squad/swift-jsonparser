import Foundation

struct BoolParser: Parser {
    
    private var resultBool = true
    private var boolCharacters = [Character]()
    private var didRunFirstParse = false
    
    mutating func parse(_ character: Character) throws -> SupportedType? {
        if didRunFirstParse {
            return try secondParse(character)
        } else {
            try firstParse(character)
            return nil
        }
    }
    
    private mutating func firstParse(_ character: Character) throws {
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
        didRunFirstParse = true
    }
    
    private mutating func secondParse(_ character: Character) throws -> SupportedType? {
        if character == boolCharacters.first {
            boolCharacters.removeFirst()
            if boolCharacters.isEmpty {
                return resultBool
            }
        }
        return nil
    }
    
    
}
