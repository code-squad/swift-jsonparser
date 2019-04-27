import Foundation

struct BoolParser: Parser {
    mutating func result() throws -> SupportedType {
        return resultBool
    }
    
    private var resultBool = true
    private var boolCharacters = [Character]()
    private var didRunFirstParse = false
    
    
    mutating func parse(_ character: Character) throws -> Bool {
        if didRunFirstParse {
            return try secondParse(character)
        } else {
            try firstParse(character)
            return true
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
    }
    
    private mutating func secondParse(_ character: Character) throws -> Bool {
        if character == boolCharacters.first {
            boolCharacters.removeFirst()
            return true
        }
        return false
    }
    
    
    
    
}

enum BoolParsingError: Error {
    case cannotFindBoolFormat
}
